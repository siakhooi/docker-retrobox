# docker-retrobox
docker image to run retro dos/win programs

The image will find the exe file in the directory and run it.
If there are more than one program, specify 'RETRO_PROGRAM_NAME' environment variable in the docker run.

## retrobox-win32:latest

- go to folder that contains win32 program, run:
```
docker run --rm -it --name retrobox-win32 -p 6080:6080 \
    -e HOST_UID="$(id -u)" \
    -e HOST_GID="$(id -g)" \
    -v "$(pwd)":/retrobox:rw \
    "siakhooi/retrobox-win32:latest"

# or

docker run --rm -it --name retrobox-win32 -p 6080:6080 \
    -e HOST_UID="$(id -u)" \
    -e HOST_GID="$(id -g)" \
    -e RETRO_PROGRAM_NAME=application123.exe \
    -v "$(pwd)":/retrobox:rw \
    "siakhooi/retrobox-win32:latest"

```
- go to browser, navigate to `http://localhost:6080`
