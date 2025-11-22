#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o verbose

# appコンテナでコマンド実行
cd ${BASE_DIR}
docker compose exec -it app "$@"
