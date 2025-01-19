#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

# Sphinxコンテナ実行
# docker compose run --rm sphinx $@
cd ${BASE_DIR}
docker run -it --rm     \
    -h sphinx           \
    -v "./docs/:/docs/" \
    -v "./containers/app/code/:/code/" \
    sphinxdoc/sphinx-latexpdf $@
