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

echo -e "### ssl設定用の自己証明書作成(CA証明書)"
CA_KEY=/etc/pki/tls/private/ca.key
CA_CSR=/etc/pki/tls/certs/ca.csr
CA_CRT=/etc/pki/tls/certs/ca.crt
openssl genpkey -out ${CA_KEY} -algorithm ED25519
openssl req     -out ${CA_CSR} -new -key ${CA_KEY} -subj "/C=JP/ST=Toaru-ken/L=Toaru-shi/O=X/OU=X/CN=PrivateCA"
openssl x509    -in ${CA_CSR} -req -key ${CA_KEY} -out ${CA_CRT} -days 7300
echo -e "### ssl設定用の自己証明書作成(サーバ証明書)"
SV_KEY=/etc/pki/tls/private/localhost.key
SV_CSR=/etc/pki/tls/certs/localhost.csr
SV_CRT=/etc/pki/tls/certs/localhost.crt
openssl genpkey -out ${SV_KEY} -algorithm ED25519
openssl req     -out ${SV_CSR} -new -key ${SV_KEY} -subj "/C=JP/ST=Toaru-ken/L=Toaru-shi/O=X/OU=X/CN=localhost"
openssl x509    -in ${SV_CSR} -req -out ${SV_CRT} -set_serial 1 -days 7300 -CA ${CA_CRT} -CAkey ${CA_KEY}
echo -e "### ssl設定用の自己証明書作成結果確認"
openssl x509 -in ${SV_CRT} -noout -text

echo -e "### httpdサービス設定"
ln -sf {${SCRIPT_DIR},/etc/httpd}/conf.d/code.conf
ln -sf {${SCRIPT_DIR},/etc/httpd}/conf.modules.d/50-code.conf
apachectl configtest

echo -e "### httpdサービス有効化"
systemctl enable httpd.service
systemctl list-unit-files httpd.service
