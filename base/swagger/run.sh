#!/bin/bash
set -e

repo=$1
tag=$2
shift 2

DOCKER_REGISTRY=$DOCKER_REGISTRY
DOCKER_USER=$DOCKER_USER
DOCKER_ENV=${DOCKER_ENV:-DEVELOPMENT}
DOCKER_BINDS_DIR=$DOCKER_BINDS_DIR

container=$DOCKER_USER-$repo
image=$DOCKER_REGISTRY$DOCKER_USER/$repo:$tag

proxy=$PROXY_HOST
[ "$PROXY_PORT" ] && proxy=$proxy:$PROXY_PORT
API_URL=${API_URL:-https://$proxy/$DOCKER_USER/api}

docker container run --restart always --name "$container" \
	-e DOCKER_USER="$DOCKER_USER" \
	--network "$DOCKER_USER" \
	-e API_URL="$API_URL" \
	"$@" \
	-d "$image"
