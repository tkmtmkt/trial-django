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

echo -e "### httpdサービス設定"
ln -sf {${SCRIPT_DIR},/etc/httpd}/conf.d/code.conf
ln -sf {${SCRIPT_DIR},/etc/httpd}/conf.modules.d/50-code.conf

echo -e "### ssl設定用の自己証明書作成"
openssl req -out /etc/pki/tls/certs/localhost.crt \
  -newkey ED25519 -noenc -keyout /etc/pki/tls/private/localhost.key \
  -x509 -subj "/C=JP/ST=Toaru-ken/L=Toaru-shi/O=X/OU=X/CN=example.com" -days 365

echo -e "### httpdサービス有効化"
systemctl enable httpd.service
systemctl list-unit-files httpd.service
