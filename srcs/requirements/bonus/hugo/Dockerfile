# requirements/bonus/hugo/Dockerfile
FROM debian:bullseye-slim

# Install Hugo
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/gohugoio/hugo/releases/download/v0.111.3/hugo_0.111.3_linux-amd64.deb && \
    dpkg -i hugo_*.deb && \
    rm hugo_*.deb && \
    apt-get clean

# Copy Hugo project files
COPY tools/index.md /src/content/_index.md
COPY tools/single.html /src/layouts/_default/single.html
COPY tools/styles.css /src/static/styles.css
COPY tools/config.toml /src/config.toml


# Create output directory and build
WORKDIR /src
RUN mkdir -p /var/www/html/hugo
CMD ["hugo", "--destination", "/var/www/html/hugo", "--minify", "--baseURL=/hugo/"]
