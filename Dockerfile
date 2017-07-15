FROM node:6.11.1

MAINTAINER Matt Farmer <matt@frmr.me>

RUN apt-get update && \
  apt-get install -y zip unzip && \
  apt-get clean

ADD https://github.com/TryGhost/Ghost/releases/download/1.0.0-rc.1/Ghost-1.0.0-rc.1.zip /opt

RUN unzip /opt/Ghost-1.0.0-rc.1.zip -d /opt/ghost

WORKDIR /opt/ghost

ENV DEBIAN_FRONTEND noninteractive

RUN adduser ghost

RUN chown -R ghost:ghost /opt/ghost

USER ghost

RUN npm install

RUN ln -s /opt/ghost/content/config.js /opt/ghost/config.js

VOLUME /opt/ghost/content

