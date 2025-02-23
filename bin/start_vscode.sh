#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

export PUID=$(id -u)
export PGID=$(id -g)

# vscodeコンテナ実行
cd ${BASE_DIR}
docker-compose up vscode "$@"
