FROM python:3.11.11-slim
MAINTAINER Takamatsu Makoto <tkmtmkt@gmail.com>

ENV LANG=ja_JP.UTF-8

WORKDIR /code

COPY Pipfile .
COPY Pipfile.lock .

RUN pip install --upgrade pip pipenv
RUN pipenv install --system --deploy
