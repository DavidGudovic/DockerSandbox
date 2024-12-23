#!/bin/sh

XDEBUG_MODE=${XDEBUG_MODE:-debug} \
  docker compose -f docker-compose.yaml -f docker-compose.dev.yaml \
  --env-file ./app/.env.dev up "$@"