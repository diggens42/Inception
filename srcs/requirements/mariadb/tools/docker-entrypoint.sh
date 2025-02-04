#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    echo "MariaDB data directory initialized."

    # mysqld --skip-networking --user=mysql --datadir=/var/lib/mysql &
    # pid="$!"

    # echo "Waiting for MariaDB to start..."
    # while ! mariadb -uroot -e "SELECT 1;" &>/dev/null; do
    #     sleep 1
    # done

    # echo "Setting up initial database and users..."

    # Set root password and create user
    mysqld --skip-networking --user=mysql --datadir=/var/lib/mysql <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\`;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
        CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
        GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
        FLUSH PRIVILEGES;
EOSQL

    # Ensure WordPress user exists and can connect from any host
#     if [ -n "$MARIADB_USER" ] && [ -n "$MARIADB_USER_PASSWORD" ]; then
#         echo "Creating user: $MARIADB_USER"
#         mariadb -uroot -p"${MARIADB_ROOT_PASSWORD}" <<-EOSQL
#             DROP USER IF EXISTS '$MARIADB_USER'@'localhost';
#             DROP USER IF EXISTS '$MARIADB_USER'@'%';
#             CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
#             GRANT ALL PRIVILEGES ON \`$MARIADB_DATABASE\`.* TO '$MARIADB_USER'@'%';
#             FLUSH PRIVILEGES;
# EOSQL
#     fi

    echo "Database setup completed."
    echo "Shutting down MariaDB..."
    # kill "$pid"
    # wait "$pid"
fi

exec mysqld --user=mysql --datadir=/var/lib/mysql
