#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

cd ${BASE_DIR}
if [[ ${DEBUG:-"False"} == "True" ]]; then
  pipenv run python manage.py runserver
else
  pipenv run gunicorn config.wsgi --bind 0.0.0.0:8000
fi
