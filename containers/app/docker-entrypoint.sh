#!/bin/sh
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o verbose

if [ $(id -u) = 0 ]; then
  USER=code
  USER_ID=${PUID:-20000}
  GROUP_ID=${PGID:-20000}

  echo "Starting with UID : ${USER_ID}, GID: ${GROUP_ID}"
  usermod -u ${USER_ID} -o ${USER}
  groupmod -g ${GROUP_ID} ${USER}

  chown -R ${GROUP_ID}:${USER_ID} /code /data

  exec su-exec ${USER} "$@"
fi

exec "$@"
