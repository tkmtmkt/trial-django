#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o verbose

cd ${BASE_DIR}
case "$1" in
  start)
    # コンテナ実行
    docker-compose up openvscode
    ;;
  stop)
    # コンテナ停止
    docker-compose down openvscode
    ;;
  *)
    echo "Usage: $0 [ start | stop ]"
    ;;
esac

cd ${BASE_DIR}
docker-compose up openvscode "$@"
