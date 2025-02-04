#!/bin/bash
set -e

sleep 35  # Wait for database

if [ ! -f /var/www/html/index.php ]; then
    echo "WordPress not found. Downloading..."
    wp core download --allow-root
fi

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php from sample..."

    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    sed -i "s/database_name_here/${DB_DATABASE}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${DB_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${DB_USER_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${DB_HOST}/" /var/www/html/wp-config.php

    echo "wp-config.php configured!"
fi

exec "$@"
