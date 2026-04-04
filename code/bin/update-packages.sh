#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

uv sync --upgrade
uv run mod_wsgi-express module-config > ${BASE_DIR}/etc/httpd/conf.modules.d/50-code.conf
