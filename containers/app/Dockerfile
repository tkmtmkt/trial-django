FROM python:3.12.9-alpine
LABEL maintainer="Takamatsu Makoto <tkmtmkt@gmail.com>"

# OSパッケージインストール
RUN apk add --no-cache \
    su-exec \
    shadow

# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
ENV PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1

# pip更新、pipenvインストール
ENV PIP_TRUSTED_HOST="pypi.org pypi.python.org files.pythonhosted.org"
RUN pip install --no-cache-dir --upgrade \
    pip \
    pipenv

# 実行ユーザ追加
RUN useradd -u 20000 -m code

WORKDIR /code

# プログラムコピー
COPY ./code/ /code/
RUN mkdir /data \
 && chown -R code:code /code /data

# Pythonパッケージインストール
ENV PIPENV_VENV_IN_PROJECT=1
RUN su-exec code pipenv install --deploy --extra-pip-args="--no-cache-dir" \
 && rm -rf /home/code/.local/share/virtualenv/

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/code/bin/run.sh"]
