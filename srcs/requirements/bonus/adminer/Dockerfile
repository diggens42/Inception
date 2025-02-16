FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y \
    php7.4 \
    php7.4-cli \
    php7.4-mysql \
    php7.4-curl \
    php7.4-json \
    php7.4-zip \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/index.php

EXPOSE 9001

CMD ["php", "-S", "0.0.0.0:9001", "-t", "/var/www/html"]
