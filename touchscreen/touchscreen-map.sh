#!/usr/bin/env bash

# map the touchscreen only to the internal screen (in case of external monitor plugged)

xinput --list | grep -oP 'ELAN.*id=\K([0-9]*)' | xargs -I{} xinput --map-to-output {} eDP-1