# Use a minimal base image
FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Add Docker's official GPG key
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker CLI and Compose plugin
RUN apt-get update && apt-get install -y \
    docker-ce-cli \
    docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# Create a symlink for docker-compose
RUN ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose

# Debugging: Verify docker-compose-plugin installation
RUN docker compose version

# Download and install Portainer
RUN curl -L https://github.com/portainer/portainer/releases/download/2.18.4/portainer-2.18.4-linux-amd64.tar.gz -o /tmp/portainer.tar.gz && \
    tar -xzf /tmp/portainer.tar.gz -C /tmp && \
    mv /tmp/portainer/portainer /usr/local/bin/portainer && \
    rm -rf /tmp/portainer*

# Expose the Portainer port
EXPOSE 9000

# Set the entrypoint to run Portainer
ENTRYPOINT ["/usr/local/bin/portainer"]
