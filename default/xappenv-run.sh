#!/usr/bin/env bash

set -e

# change as needed:
R=1nnoserv:15000/xbuildenv
C=xappenv
T=glibc-2.24-amd64

##

if [ -z "${1}" ]; then
    echo "Usage:"
    echo "\t$(basename ${0} /path/to/xprog)"
    exit 1
fi

if [ ! -x "$(which xauth)" ] || [ ! -x "$(which xhost)" ]; then
    echo "xauth and xhost required, please install it"
    exit 1
fi

cleanup() {
    xhost -localhost
    rm -f /tmp/.docker.xauth
}
trap cleanup EXIT

APPDIR="$(cd $(dirname "${1}"); pwd)"
APP="$(basename ${1})"
shift  # after this we can just pass $@ to the app

podman pull --tls-verify=false ${R}/${C}:${T}

xhost +localhost
rm -f /tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -

# TODO: fix container entrypoint so that it's not needed to override
podman run -it --rm -e DISPLAY=unix$DISPLAY \
    --entrypoint='["/bin/bash", "-c"]' \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
    -e XAUTHORITY=/tmp/.docker.xauth \
    -v "${APPDIR}":/myapp \
    ${C} /myapp/${APP} $@
