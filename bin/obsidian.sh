#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o verbose

CMD=${1:-start}

cd ${BASE_DIR}
case "$CMD" in
  start)
    # コンテナ実行
    docker-compose up obsidian
    ;;
  stop)
    # コンテナ停止
    docker-compose down obsidian
    ;;
  *)
    echo "Usage: $0 [ start | stop ]"
    ;;
esac
