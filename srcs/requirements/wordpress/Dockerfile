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
    php7.4-redis \
    redis-tools \
    mariadb-client \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN echo "extension=redis.so" > /etc/php/7.4/mods-available/redis.ini && \
    phpenmod redis

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

RUN mkdir -p /run/php

# EXPOSE 9000

WORKDIR /var/www/html

COPY tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh


ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["php-fpm7.4", "--nodaemonize"]
