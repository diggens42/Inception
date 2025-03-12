FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY portfolio.html /var/www/html/
COPY nginx.conf /etc/nginx/conf.d/

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
