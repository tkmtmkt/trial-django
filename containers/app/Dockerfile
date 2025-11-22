FROM python:3.12.9-slim
LABEL maintainer="Takamatsu Makoto <tkmtmkt@gmail.com>"

# OSパッケージインストール
RUN --mount=type=cache,target=/var/lib/apt/lists <<'EOF'
apt-get update
apt-get install -y \
        gosu
apt-get clean
EOF

# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
ENV PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1

# pip更新、pipenvインストール
ENV PIP_TRUSTED_HOST="pypi.org pypi.python.org files.pythonhosted.org"
RUN pip install --no-cache-dir --upgrade \
    pip \
    uv

# 実行ユーザ追加
RUN useradd -u 20000 -m code

WORKDIR /code

# プログラムコピー
COPY ./code/ /code/
RUN mkdir /data \
 && chown -R code:code /code /data

# Pythonパッケージインストール
RUN --mount=type=cache,target=/home/code/.local/share/virtualenv <<'EOF'
gosu code uv sync
EOF

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/code/bin/run.sh"]
