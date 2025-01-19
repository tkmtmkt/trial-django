#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

# アプリケーションコンテナ作成
# docker comose build
cd ${BASE_DIR}
docker build -t trial-django_app \
             ${BASE_DIR}/containers/app
docker build -t trial-django_web \
             ${BASE_DIR}/containers/nginx
docker build -t trial-django_sphinx \
             ${BASE_DIR}/containers/sphinx

VERSION=$(date +%Y%m%d-%H%M)
docker tag trial-django_app:latest trial-django_app:${VERSION}
docker tag trial-django_web:latest trial-django_web:${VERSION}
docker tag trial-django_sphinx:latest trial-django_sphinx:${VERSION}
