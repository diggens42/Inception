#!/bin/bash

PORTAINER_PASSWORD=$(cat /run/secrets/portainer_password | tr -d '\n\r')

if [ -z "$PORTAINER_USER" ] || [ -z "$PORTAINER_PASSWORD" ]; then
  echo "Error: PORTAINER_USER or PORTAINER_PASSWORD not set."
  exit 1
fi

if [ ! -f "/data/portainer.db" ]; then
  echo "First startup: creating admin user"

  /portainer/portainer --admin-password "$PORTAINER_PASSWORD" &

  sleep 10
fi

/portainer/portainer --user "$PORTAINER_USER" --password "$PORTAINER_PASSWORD"
