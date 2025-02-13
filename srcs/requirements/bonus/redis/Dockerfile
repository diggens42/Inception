FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data && chown redis:redis /data

COPY conf/redis.conf /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]
