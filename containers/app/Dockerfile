FROM python:3.11.11-slim
MAINTAINER Takamatsu Makoto <tkmtmkt@gmail.com>

ENV PYTHONUNBUFFERED=1
ENV LANG=ja_JP.UTF-8

WORKDIR /code

#COPY ./code/ /code/
COPY ./code/Pipfile .
COPY ./code/Pipfile.lock .

RUN pip install --upgrade pip pipenv \
  && pipenv install --system --deploy

