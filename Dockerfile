FROM node:6.11.1

MAINTAINER Matt Farmer <matt@frmr.me>

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64

RUN chmod +x /usr/local/bin/dumb-init

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

RUN ln -s /ghost/config.production.json /opt/ghost/config.production.json

RUN mv /opt/ghost/content /opt/ghost/content-default && \
  ln -s /ghost /opt/ghost/content

VOLUME /ghost

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD ["npm", "start"]

EXPOSE 2368
