FROM python:3.12.9-slim
LABEL maintainer="Takamatsu Makoto <tkmtmkt@gmail.com>"

ENV LANG=ja_JP.UTF-8
# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
ENV PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1

# pip更新、pipenvインストール
ENV PIP_TRUSTED_HOST="pypi.org pypi.python.org files.pythonhosted.org"
RUN pip install --upgrade pip pipenv

# 実行ユーザ追加
RUN useradd -u 1234 -o -m django && \
    groupmod -g 1234 django

# プログラムコピー
WORKDIR /code
COPY ./code/ /code/
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN mkdir /data && \
    chown -R django:django /code /data && \
    chmod a+x /docker-entrypoint.sh

# Pythonパッケージインストール
ENV PIPENV_VENV_IN_PROJECT=1
RUN su django -c "pipenv install --deploy"

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/code/bin/run.sh"]
