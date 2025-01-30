FROM debian:bullseye-slim

RUN apt-get update && \
	apt-get install -y nginx openssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN useradd -m fwahl

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/cert.pem /etc/nginx/ssl/cert.pem
COPY conf/key.pem /etc/nginx/ssl/key.pem

RUN chown -R www-data:www-data /etc/nginx/ssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
