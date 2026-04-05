#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# 実行ユーザ判定
if [[ $(id -u) -ne 0 ]]; then
  echo "fail: run as root"
  exit 1
fi

echo -e "### サービス設定"
mkdir -p /etc/systemd/system/httpd.service.d
ln -sf {${SCRIPT_DIR},/etc/systemd}/system/httpd.service.d/override.conf
ln -sf {${SCRIPT_DIR},/etc/systemd}/system/code1.timer
ln -sf {${SCRIPT_DIR},/etc/systemd}/system/code1.service
systemctl enable code1.timer
ln -sf {${SCRIPT_DIR},/etc/systemd}/system/code2.path
ln -sf {${SCRIPT_DIR},/etc/systemd}/system/code2.service
systemctl enable code2.path
systemctl list-unit-files code*
