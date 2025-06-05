#!/bin/bash

readonly DOCKERFILE=./Dockerfile
readonly IMAGE_TAG=siakhooi/retrobox-win32:latest

if [[ ! -f $DOCKERFILE ]]; then
    echo "Missing Dockerfile ($DOCKERFILE)!" >&2
    exit 1
fi

WORKING_DIR=.

set -ex
docker build -f "$DOCKERFILE" -t "$IMAGE_TAG" "$WORKING_DIR"
