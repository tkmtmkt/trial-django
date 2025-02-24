#!/usr/bin/env bash
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

USER=django
USER_ID=${PUID:-1234}
GROUP_ID=${PGID:-1234}

echo "Starting with UID : ${USER_ID}, GID: ${USER_ID}"
usermod -u ${USER_ID} -o ${USER}
groupmod -g ${USER_ID} ${USER}
export HOME=/home/${USER}

chown -R django:django /code /data

exec su ${USER} -c "$@"
