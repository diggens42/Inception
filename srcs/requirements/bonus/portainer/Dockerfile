FROM debian:bullseye-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget tar bash && \
    wget https://github.com/portainer/portainer/releases/download/2.19.1/portainer-2.19.1-linux-amd64.tar.gz && \
    tar -xvf portainer-2.19.1-linux-amd64.tar.gz && \
    rm portainer-2.19.1-linux-amd64.tar.gz

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
