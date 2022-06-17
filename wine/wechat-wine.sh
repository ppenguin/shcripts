#!/usr/bin/env bash

WINE=$(which wine)
# WINE=${WINE:-$(which wine)} # only works with 32 bit anyway

if [ -z "${WINE}" ]; then
    echo "No wine64 or wine found, please install it"
    exit 1
fi

# FIXME: not working (fonts and colours?)

export WINE_PREFIX=~/.deepinwine/Deepin-WeChat/
# ${WINE} "${WINE_PREFIX}/drive_c/Program Files/Tencent/WeChat/WeChat.exe"
# run with nixGL flake
nix run --override-input nixpkgs nixpkgs/nixos-21.11 --impure github:guibou/nixGL -- ${WINE} "${WINE_PREFIX}/drive_c/Program Files/Tencent/WeChat/WeChat.exe"

