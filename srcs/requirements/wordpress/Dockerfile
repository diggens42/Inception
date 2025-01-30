FROM debian:bullseye-slim

ENV WORDPRESS_VERSION=6.3.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    # php \
    php-fpm \
    php-mysql \
    php-cgi \
    php-gd \
    php-curl \
    php-xml \
    php-mbstring \
    php-zip \
    php-intl \
    mariadb-client \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz && \
    tar -xzf wordpress-${WORDPRESS_VERSION}.tar.gz && \
    rm wordpress-${WORDPRESS_VERSION}.tar.gz && \
    mkdir -p /var/www/html && \
    mv wordpress /var/www/html


# RUN mkdir -p /tools && \
#     cp /var/www/html/wp-config-sample.php /tools/www.config

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 9000

CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
