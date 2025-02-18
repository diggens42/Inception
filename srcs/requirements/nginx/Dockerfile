FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx openssl curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssl/certs /etc/ssl/private

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/CN=localhost"

RUN chmod 644 /etc/ssl/certs/nginx.crt && \
    chmod 640 /etc/ssl/private/nginx.key && \
    chown root:www-data /etc/ssl/private/nginx.key

# RUN mkdir -p /var/www/html

# COPY ./portfolio /var/www/html/portfolio

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
