#! /bin/bash

set -e

for CONF_FILE in `find /etc/nginx/sites-enabled -type f -name "*.conf"`; do
	sed -i "s/__NGINX_DOMAIN__/$NGINX_DOMAIN/g" $CONF_FILE
done;

exec "$@"
