FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    curl \
    tar \
    php-fpm \
    php-mysqli \
    php-xml \
    php-mbstring \
    php-curl \
    php-zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress /var/www/html && \
    rm latest.tar.gz

RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

WORKDIR /var/www/html

CMD ["php-fpm7.4", "-F"]
