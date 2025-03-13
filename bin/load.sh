#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o verbose

PROJECT_NAME="trial-django"

load_image () {
  SERVICE=$1
  TAG="${PROJECT_NAME}-${SERVICE}"

  # イメージファイル名
  IMAGE_FILE=$(ls ${BASE_DIR}/image/${TAG}*.tar.gz | tail -1)

  # Dockerイメージ登録
  IMAGE_ID_OLD=$(docker image list -q ${TAG}:latest)
  cat ${IMAGE_FILE} | gzip -d | docker load
  IMAGE_ID_NEW=$(docker image list -q ${TAG}:latest)

  # イメージファイル名でタグ設定
  if [ "${IMAGE_ID_NEW}" != "${IMAGE_ID_OLD}" ]; then
    VERSION=$(basename ${IMAGE_FILE})
    docker tag ${TAG}:latest ${TAG}:${VERSION}
  fi
}

load_image app
load_image web
