#!/usr/bin/env bash
# все четыре прогона подряд (~50 минут). caffeinate не даёт маку уснуть.
set -e
cd "$(dirname "$0")"
for s in nocache cache redis-stop redis-flush; do
  echo "===== $s ====="
  caffeinate -i ./experiment.sh "$s"
  sleep 20   # пауза, чтобы на графиках прогоны не слипались
done
