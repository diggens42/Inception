#!/bin/bash
set -e

DATADIR="/var/lib/mysql"

if [ ! -d "$DATADIR/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir="$DATADIR"
    echo "MariaDB data directory initialized."

    mysqld --skip-networking --user=mysql --datadir="$DATADIR" &
    pid="$!"

    echo "Waiting for MariaDB to start..."
    while ! mariadb -uroot -e "SELECT 1;" &>/dev/null; do
        sleep 1
    done

    echo "Setting up initial database and users..."

    mariadb -uroot <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    if [ -n "$MARIADB_DATABASE" ]; then
        echo "Creating database: $MARIADB_DATABASE"
        mariadb -uroot -p"${MARIADB_ROOT_PASSWORD}" <<-EOSQL
            CREATE DATABASE IF NOT EXISTS \`$MARIADB_DATABASE\`;
EOSQL
    fi

    if [ -n "$MARIADB_USER" ] && [ -n "$MARIADB_PASSWORD" ]; then
        echo "Creating user: $MARIADB_USER"
        mariadb -uroot -p"${MARIADB_ROOT_PASSWORD}" <<-EOSQL
            CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
            GRANT ALL PRIVILEGES ON \`$MARIADB_DATABASE\`.* TO '$MARIADB_USER'@'%';
            FLUSH PRIVILEGES;
EOSQL
    fi

    echo "Database setup completed."

    echo "Shutting down MariaDB..."
    kill "$pid"
    wait "$pid"
fi

exec mysqld --user=mysql --datadir="$DATADIR"
