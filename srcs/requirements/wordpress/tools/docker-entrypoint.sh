#!/bin/bash
set -e

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    sleep 1
done

echo "MariaDB is up! Setting up WordPress..."

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "wp-config.php not found! Creating from template..."
    envsubst < /var/www/html/tools/wp-config.php > /var/www/html/wp-config.php
fi

echo "Starting WordPress..."
exec php-fpm
