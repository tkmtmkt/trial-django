FROM python:3.12.9-slim
LABEL maintainer="Takamatsu Makoto <tkmtmkt@gmail.com>"

ENV LANG=ja_JP.UTF-8
# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
ENV PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1
# コンテナのワークディレクトリを/codeに指定
WORKDIR /code

COPY ./code/ /code/

RUN pip install --upgrade pip pipenv
ENV PIPENV_VENV_IN_PROJECT=1
RUN pipenv install --deploy

CMD ["/code/bin/run.sh"]
