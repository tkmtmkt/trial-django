#!/usr/bin/env bash
#
# SSL証明書作成
#
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

CA_FILE_BASE=${SCRIPT_DIR}/CA
SERVER_FILE_BASE=${SCRIPT_DIR}/server

########################################
# CA証明書作成
########################################
echo "========== create CA cert =========="

# CA用の秘密鍵を作成
openssl genpkey \
  -out ${CA_FILE_BASE}.key \
  -algorithm ED25519

# 秘密鍵と識別情報から証明書署名要求(CSR)の作成
# -subj
#   CC : 2文字の国コード。日本はJP。
#   ST : 都道府県
#   L  : 市町村
#   O  : 組織の名称
#   OU : 組織の部門名
#   CN : サーバのFQDN
openssl req -batch -new \
  -out ${CA_FILE_BASE}.csr \
  -key ${CA_FILE_BASE}.key \
  -subj "/CC=JP/ST=Kanagawa/L=Yokohama-shi/O=X/OU=X/CN=PrivateCA"

# 公開鍵が入ったCSRを秘密鍵で自己署名してCA証明書を発行
openssl x509 -req -days 7300 \
  -in ${CA_FILE_BASE}.csr \
  -out ${CA_FILE_BASE}.crt \
  -signkey ${CA_FILE_BASE}.key

# 作成したCA証明書の内容を確認
openssl x509 -text -noout -in ${CA_FILE_BASE}.crt

########################################
# サーバ証明書作成
########################################
echo "========== create server cert =========="

# サーバ用の秘密鍵を作成
openssl genpkey \
  -out ${SERVER_FILE_BASE}.key \
  -algorithm ED25519

# 秘密鍵と識別情報から証明書署名要求(CSR)の作成
openssl req -batch -new \
  -out ${SERVER_FILE_BASE}.csr \
  -key ${SERVER_FILE_BASE}.key \
  -subj "/CC=JP/ST=Kanagawa/L=Yokohama-shi/O=X/OU=X/CN=www11234ui.sakura.ne.jp"

# 証明書に付加するSAN(Subject Alternative Name サブジェクト代替名)を入れたテキストファイルを作成
echo "subjectAltName =" \
     "DNS:localhost," \
     "DNS:localhost.localdomain," \
     "IP:127.0.0.1," \
     "DNS:www11234ui.sakura.ne.jp," \
     "IP:133.242.160.248" \
     > ${SERVER_FILE_BASE}.csx

# CSRにSAN情報を付加しCA秘密鍵とCA証明書で署名してサーバ証明書を作成
openssl x509 -req -days 7300 \
  -in ${SERVER_FILE_BASE}.csr \
  -out ${SERVER_FILE_BASE}.crt \
  -CA ${CA_FILE_BASE}.crt \
  -CAkey ${CA_FILE_BASE}.key \
  -CAcreateserial \
  -extfile ${SERVER_FILE_BASE}.csx

# 作成したサーバ証明書の内容を確認
openssl x509 -text -noout -in ${SERVER_FILE_BASE}.crt
