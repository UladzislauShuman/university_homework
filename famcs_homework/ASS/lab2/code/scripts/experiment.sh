#!/usr/bin/env bash
# один прогон эксперимента. сам запускает сервис, нагрузку и (если нужно) ломает redis.
#
#   ./scripts/experiment.sh nocache       базовый сценарий: сервис ходит только в postgres
#   ./scripts/experiment.sh cache         redis + cache-aside, кэш прогрет заранее
#   ./scripts/experiment.sh redis-stop    как cache, но на 3-й минуте redis выключается, на 6-й включается
#   ./scripts/experiment.sh redis-flush   как cache, но на 3-й и 6-й минуте кэш очищается FLUSHALL
#
# параметры можно переопределить: THREADS=200 DURATION=600 ./scripts/experiment.sh cache
set -euo pipefail
cd "$(dirname "$0")/.."

SCENARIO="$1"
THREADS="${THREADS:-200}"
DURATION="${DURATION:-600}"
RAMPUP="${RAMPUP:-30}"
EVENT1="${EVENT1:-180}"      # секунда первого события
EVENT2="${EVENT2:-360}"      # секунда второго события
OUT="results/$SCENARIO"
GRAFANA="http://localhost:3000"
export JAVA_HOME="${JAVA_HOME:-$(/usr/libexec/java_home -v 25)}"

now_ms() { python3 -c 'import time; print(int(time.time()*1000))'; }

# отметка на графиках grafana (красная вертикальная линия)
annotate() {
  curl -s -X POST "$GRAFANA/api/annotations" -H 'Content-Type: application/json' \
       -d "{\"dashboardUID\": \"lab2\", \"time\": $(now_ms), \"tags\": [\"$SCENARIO\"], \"text\": \"$1\"}" > /dev/null || true
  echo "[$(date +%T)] $1"
}

case "$SCENARIO" in
  nocache) CACHE=false ;;
  cache|redis-stop|redis-flush) CACHE=true ;;
  *) echo "неизвестный сценарий $SCENARIO"; exit 1 ;;
esac

rm -rf "$OUT" && mkdir -p "$OUT"

# 0. redis должен быть жив и пуст перед каждым прогоном
docker start lab2-redis > /dev/null
until docker exec lab2-redis redis-cli PING 2>/dev/null | grep -q PONG; do sleep 0.5; done
docker exec lab2-redis redis-cli FLUSHALL > /dev/null

# 1. свежий сервис на компе
pkill -f users-api-1.0.0.jar 2>/dev/null && sleep 2 || true
CACHE_ENABLED=$CACHE nohup "$JAVA_HOME/bin/java" -Xms1g -Xmx1g -jar app/target/users-api-1.0.0.jar > "$OUT/app.log" 2>&1 &
APP_PID=$!
trap 'kill $APP_PID 2>/dev/null || true' EXIT
until curl -sf localhost:8080/actuator/health > /dev/null; do sleep 0.5; done
echo "сервис запущен, cache=$CACHE"

# 2. прогрев кэша: по разу каждый id
if [ "$CACHE" = true ]; then
  jmeter -n -t jmeter/warmup.jmx -q jmeter/lab2.properties -l "$OUT/warmup.jtl" -j "$OUT/warmup.log" | grep "summary =" | tail -1
  echo "ключей в redis после прогрева: $(docker exec lab2-redis redis-cli DBSIZE)"
fi
sleep 5

# 3. нагрузка
START=$(now_ms)
annotate "$SCENARIO: старт нагрузки"
HEAP="-Xms1g -Xmx1g" jmeter -n -t jmeter/users.jmx -q jmeter/lab2.properties \
     -Jthreads="$THREADS" -Jrampup="$RAMPUP" -Jduration="$DURATION" \
     -l "$OUT/result.jtl" -j "$OUT/jmeter.log" > "$OUT/jmeter-console.log" 2>&1 &
JM_PID=$!

E1=""; E2=""
if [ "$SCENARIO" = redis-stop ]; then
  sleep "$EVENT1"; E1=$(now_ms); docker stop lab2-redis > /dev/null; annotate "docker stop redis"
  sleep $((EVENT2 - EVENT1)); E2=$(now_ms); docker start lab2-redis > /dev/null; annotate "docker start redis (пустой)"
elif [ "$SCENARIO" = redis-flush ]; then
  sleep "$EVENT1"; E1=$(now_ms); docker exec lab2-redis redis-cli FLUSHALL > /dev/null; annotate "FLUSHALL #1"
  sleep $((EVENT2 - EVENT1)); E2=$(now_ms); docker exec lab2-redis redis-cli FLUSHALL > /dev/null; annotate "FLUSHALL #2"
fi

wait $JM_PID
END=$(now_ms)
annotate "$SCENARIO: конец нагрузки"
grep "summary =" "$OUT/jmeter-console.log" | tail -1

# времена прогона — для графиков и скриншотов grafana
cat > "$OUT/meta.json" <<JSON
{"scenario": "$SCENARIO", "threads": $THREADS, "duration": $DURATION, "rampup": $RAMPUP,
 "start_ms": $START, "end_ms": $END, "event1_ms": "${E1}", "event2_ms": "${E2}"}
JSON

# 4. html-отчёт jmeter
HEAP="-Xms6g -Xmx6g" jmeter -g "$OUT/result.jtl" -q jmeter/lab2.properties -o "$OUT/jmeter-report" > /dev/null 2>&1 \
  && echo "html-отчёт: $OUT/jmeter-report/index.html" || echo "html-отчёт не собрался, см. jmeter -g вручную"
