# Set nginx base image
FROM nginx

# File Author / Maintainer
MAINTAINER Gabriel Malet

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf
COPY sites-enabled/uo.conf /etc/nginx/sites-enabled/uo.conf

COPY ./scripts/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Expose ports (SSL)
EXPOSE 443

# Define default command
CMD service nginx start
