#!/usr/bin/env bash
# перепрогон сценария "с кэшем" на тихой машине + пересчёт всех таблиц, графиков и скриншотов.
# перед запуском закрыть Planet VPN, браузеры с видео, IDE и прочее тяжёлое. ~15 минут, мак не трогать.
#
#   ./scripts/rerun_cache.sh
#
# всё, что происходит, пишется в results/rerun_cache.log
set -uo pipefail
cd "$(dirname "$0")/.."
LOG=results/rerun_cache.log
exec > >(tee "$LOG") 2>&1

echo "=== $(date '+%F %T') перепрогон cache ==="

# 0. что сейчас ест процессор (для отчёта)
echo "--- топ процессов по CPU перед стартом ---"
top -l 2 -o cpu -n 8 -stats command,cpu | tail -9
pgrep -fl "Planet VPN" > /dev/null && echo "!!! Planet VPN всё ещё запущен"

# 1. инфраструктура
docker compose up -d > /dev/null 2>&1
until docker exec lab2-postgres pg_isready -U lab2 > /dev/null 2>&1; do sleep 1; done

# 2. старый прогон в сторону, новый на его место
TS=$(date +%H%M)
[ -d results/cache ] && mv results/cache "results/cache-before-$TS"
caffeinate -i ./scripts/experiment.sh cache 2>&1 | grep -v -E "WARN|WARNING"

# 3. html-отчёт jmeter с запасом памяти (35+ млн строк)
if [ ! -f results/cache/jmeter-report/index.html ]; then
  rm -rf results/cache/jmeter-report
  HEAP="-Xms12g -Xmx12g" jmeter -g results/cache/result.jtl -q jmeter/lab2.properties -o results/cache/jmeter-report > /dev/null 2>&1
fi

# 4. таблицы, графики, скриншоты grafana
python3 scripts/analyze.py
./scripts/grafana_screens.sh

echo "=== $(date '+%F %T') готово. итог: results/summary.md, картинки: ../ответ/фото ==="
