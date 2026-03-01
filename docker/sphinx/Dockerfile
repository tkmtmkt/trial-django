FROM sphinxdoc/sphinx-latexpdf
MAINTAINER Takamatsu Makoto <tkmtmkt@gmail.com>

COPY ./requirements.txt requirements.txt
RUN pip install -f requirements.txt


COPY ./java-8u152-zulu.zip .
RUN unzip ./java-8u152-zulu.zip -d /opt
RUN rm -f ./java-8u152-zulu.zip .

COPY ./plantuml-1.2025.0.jar .
RUN mv ./plantuml-1.2025.0.jar /opt
