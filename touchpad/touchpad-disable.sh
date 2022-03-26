#!/usr/bin/env bash

# set "Disable While Typing Enabled" to 1 for touchpad

DEVID=$(xinput --list | grep -oP '.*(T|t)ouch.*id=\K([0-9]*)')
PROPID=$(xinput list-props ${DEVID} | grep -oP 'Disable While Typing Enabled\s+\(\K([0-9]*)')
xinput set-prop ${DEVID} ${PROPID} 1
