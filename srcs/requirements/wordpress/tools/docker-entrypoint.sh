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
wp config create --dbname="${DB_DATABASE}" --dbuser="${DB_USER}" --dbpass="${DB_USER_PASSWORD}" --dbhost="${DB_HOST}" --allow-root \
    --extra-php <<PHP
define('WP_REDIS_CLIENT', 'phpredis');
define('WP_REDIS_HOST', '${REDIS_HOST}');
define('WP_REDIS_PORT', ${REDIS_PORT});
define('WP_CACHE', true);
define('WP_REDIS_PATH', false);
define('WP_REDIS_DISABLED', false);
PHP

fi

if ! wp core is-installed --allow-root; then
    echo "Running WordPress installation..."
    while [ ! -f /run/secrets/wp_admin_password ]; do sleep 1; done
    WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password | tr -d '\n\r')
    wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
else
    echo "WordPress already installed. Skipping installation."
fi

if ! wp user list --field=user_login --allow-root | grep -q "^${WP_NORMAL_USER}$"; then
    echo "Creating additional WordPress user..."
    while [ ! -f /run/secrets/wp_user_password ]; do sleep 1; done
    WP_USER_PASSWORD=$(cat /run/secrets/wp_secondary_password | tr -d '\n\r')

    wp user create "${WP_NORMAL_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role="${WP_USER_ROLE}" \
        --allow-root
else
    echo "Secondary WordPress user '${WP_NORMAL_USER}' already exists. Skipping creation."
fi


if ! wp plugin list --path=/var/www/html --format=csv | grep -q "redis-cache"; then
    echo "Installing Redis Object Cache plugin..."
    wp plugin install redis-cache --activate --allow-root --path=/var/www/html
fi

wp redis enable --allow-root --path=/var/www/html
wp theme activate twentytwentyfour --allow-root

exec "$@"
