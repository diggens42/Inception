FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y inotify-tools && \
    rm -rf /var/lib/apt/lists/*

CMD ["inotifywait", "-m", "-r", "-q", "-e", "create,modify,attrib", "/var/www/html/portfolio"]
