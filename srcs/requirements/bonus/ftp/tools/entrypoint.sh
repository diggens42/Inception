#!/bin/bash
set -e

if ! id -u $FTP_USER >/dev/null 2>&1; then
    FTP_PASSWORD=$(cat /run/secrets/ftp_password | tr -d '\n\r')
    useradd -u 1001 -g www-data -d /var/www/html -s /bin/bash $FTP_USER
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

chown -R $FTP_USER:www-data /var/www/html
chmod -R 775 /var/www/html

mkdir -p /var/run/vsftpd/empty

exec vsftpd /etc/vsftpd.conf
