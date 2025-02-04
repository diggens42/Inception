#!/bin/bash
set -e

sleep 33

echo "MariaDB is up! Verifying database..."
if ! mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "USE $WORDPRESS_DB_NAME"; then
    echo "Error: Database $WORDPRESS_DB_NAME does not exist or is not accessible."
    exit 1
fi

echo "Database is ready! Setting up WordPress..."

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "wp-config.php not found! Creating from wp-config-sample.php..."

    wp core download --allow-root
    wp config create --dbname=$WORDPRESS_DB_NAME \
    --dbuser=$WORDPRESS_DB_USER \
    --dbpass=$WORDPRESS_DB_PASSWORD \
    --dbhost=$WORDPRESS_DB_HOST \
    --allow-root
    wp core install --url=$WORDPRESS_URL \
    --title=$WORDPRESS_TITLE \
    --admin_user=$WORDPRESS_ADMIN_USER \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --allow-root
    wp user create $WORDPRESS_EDITOR_USER $WORDPRESS_EDITOR_EMAIL --role=editor --user_pass=$WORDPRESS_EDITOR_PASSWORD --allow-root


    # # Copy the sample config file
    # cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    # # Replace placeholders with actual values
    # sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" /var/www/html/wp-config.php
    # sed -i "s/username_here/$WORDPRESS_DB_USER/g" /var/www/html/wp-config.php
    # sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" /var/www/html/wp-config.php
    # sed -i "s/localhost/$WORDPRESS_DB_HOST/g" /var/www/html/wp-config.php
fi

echo "Starting WordPress..."
exec php-fpm7.4 --nodaemonize
