#!/bin/bash

set -x
export DISPLAY=:1
APP_DIR="/retrobox"
echo "HOST_UID: $HOST_UID"
echo "HOST_GID: $HOST_GID"
if [[ -z "$HOST_UID" || -z "$HOST_GID" ]]; then
  echo "Error: HOST_UID and HOST_GID environment variables must be set." >&2
  exit 1
fi
sudo usermod -u "$HOST_UID" docker
sudo groupmod -g "$HOST_GID" docker
sudo chown -R docker:docker "$APP_DIR"
sudo chown -R docker:docker /home/docker

RETRO_SCREEN_RESOLUTION="${RETRO_SCREEN_RESOLUTION:-1024x768x16}"
Xvfb :1 -screen 0 "$RETRO_SCREEN_RESOLUTION" &
sleep 2

x11vnc -display :1 -nopw -forever -shared -rfbport 5900 &
/home/docker/noVNC/utils/novnc_proxy --vnc localhost:5900 &

if [[ -n "$RETRO_PROGRAM_NAME" ]]; then
  program_name="$RETRO_PROGRAM_NAME"
else
  EXE_COUNT=$(find "$APP_DIR" -maxdepth 1 -iname "*.exe" | wc -l)

  if [ "$EXE_COUNT" -eq 1 ]; then
    EXE_PATH=$(find "$APP_DIR" -maxdepth 1 -iname "*.exe" | head -n 1)
    program_name=$(basename "$EXE_PATH")
  elif [[ $EXE_COUNT -gt 1 ]]; then
    echo "Error: Multiple .exe files found in '$APP_DIR'. Please set RETRO_PROGRAM_NAME environment variable." >&2
    exit 1
  else
    echo "Error: No .exe files found in '$APP_DIR'" >&2
    exit 1
  fi
fi

program_path=$APP_DIR/$program_name

if [[ ! -f $program_path ]]; then
  echo "Error: Program '$program_name' not found at '$program_path'" >&2
  exit 1
fi
echo "Starting program: $program_path"

parent_directory=$(dirname "$program_path")
binary_name=$(basename "$program_path")

cd "$parent_directory" || {
  echo "Error: Failed to change directory to '$parent_directory'" >&2
  exit 1
}
echo "Running: $EXE_PATH"
wine "$binary_name"

tail -f /dev/null
