#!/bin/bash
set -e

sleep 50  # Wait for database

if [ ! -f /var/www/html/index.php ]; then
    echo "WordPress not found. Downloading..."
    wp core download --allow-root
fi

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php from WP-CLI..."
    while [ ! -f /run/secrets/db_user_password ]; do sleep 1; done
    DB_USER_PASSWORD=$(cat /run/secrets/db_user_password | tr -d '\n\r')
    wp config create --dbname="${DB_DATABASE}" --dbuser="${DB_USER}" --dbpass="${DB_USER_PASSWORD}" --dbhost="${DB_HOST}" --allow-root

    echo "wp-config.php configured!"
fi

if ! wp core is-installed --allow-root; then
    echo "Running WordPress installation..."
    while [ ! -f /run/secrets/wp_admin_password ]; do sleep 1; done
    WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password | tr -d '\n\r')
    wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
else
    echo "WordPress already installed. Skipping installation."
fi

exec "$@"
