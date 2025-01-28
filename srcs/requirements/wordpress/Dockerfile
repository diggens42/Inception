FROM debian:bullseye-slim

ENV WORDPRESS_VERSION=6.3.2 \
    WORDPRESS_SHA1=adf91a9b8ab11b40fbb254bb3400cba290de587c

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    php \
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
    && rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz && \
    echo "$WORDPRESS_SHA1  wordpress-${WORDPRESS_VERSION}.tar.gz" | sha1sum -c - && \
    tar -xzf wordpress-${WORDPRESS_VERSION}.tar.gz && \
    rm wordpress-${WORDPRESS_VERSION}.tar.gz && \
    mv wordpress /var/www/html

RUN mkdir -p /wordpress/tools && \
    cp /var/www/html/wp-config-sample.php /tools/www.config

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
