#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

# アプリケーションコンテナ実行
# docker compose run --rm app python manage.py runserver
cd ${BASE_DIR}
docker run -it --rm     \
    -h trial-django_app \
    -p "3000:8000"      \
    -v "./containers/app/code/:/code/" \
    -v "./containers/app/data/:/data/" \
    -w "/code"          \
    trial-django_app gunicorn config.wsgi:application
    #trial-django_app python manage.py runserver
