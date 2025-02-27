#!/bin/sh
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o verbose

if [ "$(id -u)" = 0 && "$1" = "/code/bin/run.sh" ]; then
  USER=code
  USER_ID=${PUID:-20000}
  GROUP_ID=${PGID:-20000}

  echo "Starting with UID : ${USER_ID}, GID: ${USER_ID}"
  usermod -u ${USER_ID} -o ${USER}
  groupmod -g ${USER_ID} ${USER}
  export HOME=/home/${USER}

  chown -R code:code /code /data

  exec su-exec ${USER} "$@"
fi

exec "$@"
