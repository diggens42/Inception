FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y \
    docker-ce-cli \
    docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose

RUN docker compose version

RUN curl -L https://github.com/portainer/portainer/releases/download/2.18.4/portainer-2.18.4-linux-amd64.tar.gz -o /tmp/portainer.tar.gz && \
    tar -xzf /tmp/portainer.tar.gz -C /tmp && \
    mv /tmp/portainer /usr/local/share/portainer && \
    ln -s /usr/local/share/portainer/portainer /usr/local/bin/portainer && \
    rm -rf /tmp/portainer*

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/portainer", "--http-enabled"]
