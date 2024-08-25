#!/bin/sh

# Generate SSL certificate and key if they don't exist
if [ ! -f ${CERT_} ] || [ ! -f ${CERT_KEY} ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -out ${CERT_} \
        -keyout ${CERT_KEY} \
        -subj "/C=FI/ST=Helsinki/L=Helsinki/O=Hive Helsinki/OU=student/CN=jole.42.fr"
fi
# Start NGINX
nginx -g "daemon off;"
