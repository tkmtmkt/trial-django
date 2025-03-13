#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o verbose

PROJECT_NAME="trial-django"

save_image () {
  SERVICE=$1
  TAG="${PROJECT_NAME}-${SERVICE}"

  # イメージファイル名
  IMAGE_FILE=${BASE_DIR}/image/${TAG}-$(date +%Y%m%d).tar.gz

  # Dockerイメージをファイル出力
  docker save ${TAG}:latest | gzip -c > ${IMAGE_FILE}

  # イメージファイル名でタグ設定
  VERSION=$(basename ${IMAGE_FILE})
  docker tag ${TGA}:latest ${TAG}:${VERSION}
}

save_image app
save_image web
