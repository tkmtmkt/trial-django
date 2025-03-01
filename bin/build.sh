#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o verbose

PROJECT="trial-django"

build_image () {
  SERVICE=$1
  TAG="${PROJECT}-${SERVICE}"
  # アプリケーションコンテナ作成
  IMAGE_ID_OLD=$(docker image list -q ${TAG}:latest)
  docker-compose build ${SERVICE}
  IMAGE_ID_NEW=$(docker image list -q ${TAG}:latest)

  if [ $IMAGE_ID_NEW != $IMAGE_ID_OLD ]; then
    VERSION=$(date +%Y%m%d-%H%M)
    docker tag ${TAG}:latest ${TAG}:${VERSION}
  fi
}

build_image app
build_image web
