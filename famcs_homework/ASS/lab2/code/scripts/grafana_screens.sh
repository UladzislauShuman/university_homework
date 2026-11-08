#!/usr/bin/env bash
# скриншоты дашборда grafana за время каждого прогона (headless chrome).
# картинки кладутся в ../ответ/фото/grafana-<сценарий>.png
set -euo pipefail
cd "$(dirname "$0")/.."
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
OUT="../ответ/фото"
mkdir -p "$OUT"

shot() {  # имя файла, from_ms, to_ms
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1600,1560 \
    --virtual-time-budget=20000 --screenshot="$OUT/$1.png" \
    "http://localhost:3000/d/lab2/x?orgId=1&from=$2&to=$3&kiosk&theme=light&refresh=" > /dev/null 2>&1
  echo "$OUT/$1.png"
}

for s in nocache cache redis-stop redis-flush; do
  [ -f "results/$s/meta.json" ] || continue
  read -r FROM TO E1 E2 < <(python3 -c "
import json; m = json.load(open('results/$s/meta.json'))
print(m['start_ms'] - 15000, m['end_ms'] + 15000, m['event1_ms'] or 0, m['event2_ms'] or 0)")
  shot "grafana-$s" "$FROM" "$TO"
  # для отказов — ещё крупный план: 30 с до и 90 с после каждого события
  [ "$E1" != 0 ] && shot "grafana-$s-event1" $((E1 - 30000)) $((E1 + 90000))
  [ "$E2" != 0 ] && shot "grafana-$s-event2" $((E2 - 30000)) $((E2 + 90000))
done
