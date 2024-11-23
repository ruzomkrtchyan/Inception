#!/bin/bash

# Define paths for certs and key
CERTS_DIR="/etc/nginx/ssl/certs"
PRIVATE_DIR="/etc/nginx/ssl/private"

# Create directories if they don't exist
mkdir -p $CERTS_DIR
mkdir -p $PRIVATE_DIR

# Generate SSL certificate and key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$PRIVATE_DIR/nginx-selfsigned.key" -out "$CERTS_DIR/nginx-selfsigned.crt" -subj "/C=AM/L=Yerevan/O=42/OU=student/CN=$DOMAIN_NAME"

# Navigate to Nginx configuration directory
cd /etc/nginx/sites-available/

if [ -f ./default.conf ]; then
    sed -i "s#\$DOMAIN_NAME#$DOMAIN_NAME#g" default.conf
    sed -i "s#\$CERTS_#$CERTS_DIR/nginx-selfsigned.crt#g" default.conf
    sed -i "s#\$KEYOUT_#$PRIVATE_DIR/nginx-selfsigned.key#g" default.conf

    cat default.conf > default

    rm -rf default.conf
fi

# Restart Nginx
nginx -g "daemon off;"
