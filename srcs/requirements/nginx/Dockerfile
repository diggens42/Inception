FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssl/certs /etc/ssl/private

COPY conf/cert.pem /etc/ssl/certs/cert.pem
COPY conf/key.pem /etc/ssl/private/key.pem

RUN chmod 644 /etc/ssl/certs/cert.pem
RUN chmod 640 /etc/ssl/private/key.pem
RUN chown root:www-data /etc/ssl/private/key.pem

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
