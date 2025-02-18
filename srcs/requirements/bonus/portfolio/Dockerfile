FROM debian:bullseye-slim

RUN mkdir -p /var/www/html

COPY ./tools /var/www/html/portfolio

RUN chown -R www-data:www-data /var/www/html/portfolio && \
    chmod -R 755 /var/www/html/portfolio
