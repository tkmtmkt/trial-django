#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

# アプリケーションコンテナ作成
docker build -f ${BASE_DIR}/containers/app/Dockerfile \
             -t trial-django_app \
             ${BASE_DIR}/.
docker build -f ${BASE_DIR}/containers/nginx/Dockerfile \
             -t trial-django_web \
             ${BASE_DIR}/.
