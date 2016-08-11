FROM frolvlad/alpine-mono

MAINTAINER Gabriel Malet

RUN apk update \
  && apk add wget unzip --no-cache bash \
  && rm -rf /var/cache/apk/*

COPY ./scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]