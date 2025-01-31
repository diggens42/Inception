FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-cgi \
    php7.4-gd \
    php7.4-curl \
    php7.4-xml \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-intl \
    mariadb-client \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm latest.tar.gz

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

RUN mkdir -p /run/php

EXPOSE 9000

CMD ["php-fpm7.4", "--nodaemonize"]

