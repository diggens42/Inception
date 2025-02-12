#!/bin/bash
set -e

chown -R mysql:mysql /run/mysqld


if [ ! -d "/var/lib/mysql/${DB_DATABASE}" ]; then
    while [ ! -f /run/secrets/db_root_password ]; do sleep 1; done
    DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password | tr -d '\n\r')
    while [ ! -f /run/secrets/db_user_password ]; do sleep 1; done
    DB_USER_PASSWORD=$(cat /run/secrets/db_user_password | tr -d '\n\r')
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null

    mysqld_safe &
    pid="$!"

    until mysqladmin ping --silent; do
        sleep 1
    done

    echo "Setting root password..."
    mysql -uroot -p "" <<EOF
    FLUSH PRIVILEGES;
    ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('${DB_ROOT_PASSWORD}');
    FLUSH PRIVILEGES;
EOF

    echo "Creating WordPress database and user..."
    mysql -uroot -p"${DB_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO '${DB_USER}'@'%';
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
EOF

    mysqladmin shutdown
    sleep 2
fi

exec mysqld
