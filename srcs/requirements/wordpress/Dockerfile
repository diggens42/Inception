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


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

# RUN wget https://wordpress.org/latest.tar.gz && \
#     tar -xzf latest.tar.gz -C /var/www/html --strip-components=1 && \
#     rm latest.tar.gz

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

RUN mkdir -p /run/php

# COPY tools/wp-config.php /var/www/html/wp-config.php

EXPOSE 9000


COPY tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["php-fpm7.4", "--nodaemonize"]

