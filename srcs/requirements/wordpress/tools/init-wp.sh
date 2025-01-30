#!/bin/sh

set -e

echo "Starting WordPress initialization..."

if [ ! -f "/wordpress/tools/www.config" ]; then
    echo "Error: /wordpress/tools/www.config not found!"
    exit 1
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Copying WordPress config..."
    cp /wordpress/tools/www.config /var/www/html/wp-config.php
    chown www-data:www-data /var/www/html/wp-config.php
    chmod 644 /var/www/html/wp-config.php
fi

echo "Waiting for database to be ready..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    sleep 2
done
echo "Database is ready!"

echo "Starting PHP-FPM..."
exec php-fpm -F
