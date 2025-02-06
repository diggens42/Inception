#!/bin/bash
set -e

sleep 35  # Wait for database

if [ ! -f /var/www/html/index.php ]; then
    echo "WordPress not found. Downloading..."
    wp core download --allow-root
fi

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php from WP-CLI..."

    wp config create --dbname="${DB_DATABASE}" --dbuser="${DB_USER}" --dbpass="${DB_USER_PASSWORD}" --dbhost="${DB_HOST}" --allow-root

    # cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    # sed -i "s/database_name_here/${DB_DATABASE}/" /var/www/html/wp-config.php
    # sed -i "s/username_here/${DB_USER}/" /var/www/html/wp-config.php
    # sed -i "s/password_here/${DB_USER_PASSWORD}/" /var/www/html/wp-config.php
    # sed -i "s/localhost/${DB_HOST}/" /var/www/html/wp-config.php

    echo "wp-config.php configured!"
fi

if ! wp core is-installed --allow-root; then
    echo "Running WordPress installation..."
    wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
else
    echo "WordPress already installed. Skipping installation."
fi

exec "$@"
