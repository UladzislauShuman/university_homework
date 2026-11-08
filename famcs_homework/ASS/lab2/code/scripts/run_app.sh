#!/usr/bin/env bash
# запуск сервиса на компе.
#   ./scripts/run_app.sh false   -> без кэша (базовый сценарий)
#   ./scripts/run_app.sh true    -> с redis (cache-aside)
set -e
cd "$(dirname "$0")/../app"
export CACHE_ENABLED="${1:-true}"
export JAVA_HOME="${JAVA_HOME:-$(/usr/libexec/java_home -v 25)}"
# 1 гб памяти, ровно как у базы
exec "$JAVA_HOME/bin/java" -Xms1g -Xmx1g -jar target/users-api-1.0.0.jar
