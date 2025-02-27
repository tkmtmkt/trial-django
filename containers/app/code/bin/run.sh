#!/bin/sh
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

cd ${BASE_DIR}
pipenv run python manage.py makemigrations --noinput
pipenv run python manage.py migrate --noinput
pipenv run python manage.py collectstatic --noinput

# 環境変数のDEBUGの値がTrueの時はrunserverを、Falseの時はgunicornを実行します
if [[ ${DEBUG:-"False"} == "True" ]]; then
  pipenv run python manage.py runserver 0.0.0.0:8000
else
  pipenv run gunicorn config.wsgi --bind 0.0.0.0:8000
fi
