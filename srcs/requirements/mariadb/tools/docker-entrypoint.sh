#!/bin/bash
set -e

chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/${DB_DATABASE}" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null

    mysqld_safe &
    pid="$!"

    until mysqladmin ping --silent; do
        sleep 1
    done

    echo "Setting root password..."
    mysqladmin -u root password "${DB_ROOT_PASSWORD}"

    echo "Creating WordPress database and user..."
    mysql -uroot -p"${DB_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    mysqladmin shutdown
fi

exec mysqld
