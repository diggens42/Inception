#!/bin/sh
set -e

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# No need to copy wp-config.php if it's already in /var/www/html

echo "Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    sleep 2
done

if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install --url="${WORDPRESS_URL}" --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" --allow-root
fi

exec "$@"
