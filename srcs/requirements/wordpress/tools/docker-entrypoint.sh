#!/bin/bash
set -e

sleep 33

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

    echo "Configuring Redis cache..."
    echo "define('WP_REDIS_HOST', '${REDIS_HOST}');" >> /var/www/html/wp-config.php
    echo "define('WP_REDIS_PORT', ${REDIS_PORT});" >> /var/www/html/wp-config.php
    echo "define('WP_CACHE', true);" >> /var/www/html/wp-config.php
    echo "define('WP_REDIS_DATABASE', 0);" >> /var/www/html/wp-config.php
fi

if ! wp core is-installed --allow-root; then
    echo "Running WordPress installation..."
    while [ ! -f /run/secrets/wp_admin_password ]; do sleep 1; done
    WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password | tr -d '\n\r')
    wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
else
    echo "WordPress already installed. Skipping installation."
fi

if ! wp plugin list --path=/var/www/html --format=csv | grep -q "redis-cache"; then
    echo "Installing Redis Object Cache plugin..."
    wp plugin install redis-cache --activate --allow-root --path=/var/www/html
fi

wp redis enable --allow-root --path=/var/www/html

exec "$@"
