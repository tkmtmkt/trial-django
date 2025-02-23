FROM python:3.12.9-slim
LABEL maintainer="Takamatsu Makoto <tkmtmkt@gmail.com>"

ENV PYTHONUNBUFFERED=1
ENV LANG=ja_JP.UTF-8

WORKDIR /code

COPY ./code/ /code/

RUN pip install --upgrade pip pipenv
ENV PIPENV_VENV_IN_PROJECT=1
RUN pipenv install --deploy

CMD ["/code/bin/run.sh"]
