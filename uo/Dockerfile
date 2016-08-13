FROM frolvlad/alpine-mono

MAINTAINER Gabriel Malet

RUN apk update \
  && apk add wget unzip zlib zlib-dev --no-cache bash \
  && rm -rf /var/cache/apk/*

COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./replace/* /

EXPOSE 2593

ENTRYPOINT ["/entrypoint.sh"]
