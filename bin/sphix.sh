#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

# Sphinxコンテナ実行
cd ${BASE_DIR}
docker run -it --rm     \
    -h sphinx           \
    -v "./docs/:/docs/" \
    sphinxdoc/sphinx:5.0.1 /bin/bash
