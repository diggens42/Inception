#!/bin/bash

PORTAINER_PASSWORD=$(cat /run/secrets/portainer_password | tr -d '\n\r')

if ! command -v htpasswd &> /dev/null; then
  apt-get update && apt-get install -y apache2-utils && rm -rf /var/lib/apt/lists/*
fi

HASHED_PASSWORD=$(htpasswd -nbB admin "$PORTAINER_PASSWORD" | cut -d ":" -f 2)

if [ ! -f "/data/portainer.db" ]; then
  echo "First startup: creating admin user"

  /portainer/portainer --admin-password "$HASHED_PASSWORD" &

  sleep 10
  pkill -f "/portainer/portainer"
fi

exec /portainer/portainer
