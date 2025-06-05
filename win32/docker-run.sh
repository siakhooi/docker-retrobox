#!/bin/bash

# tempDir=$(mktemp -d --tmpdir "$(basename "$0")-XXXXXXXXXX")
tempDir=../test

cd $tempDir || exit 1

readonly IMAGE_TAG=siakhooi/retrobox-win32:latest

set -x
docker run --rm -it \
    --name retrobox-win32 \
    -p 6080:6080 \
    -e HOST_UID="$(id -u)" \
    -e HOST_GID="$(id -g)" \
    -e RETRO_PROGRAM_NAME=application123.exe \
    -v "$(pwd)":/retrobox:rw \
    "$IMAGE_TAG"
