#!/usr/bin/env sh

MID=$(xinput list | sed -n 's/.*[Mm]*ouse.*id=\([0-9]*\).*/\1/p')
MSEPROP=$(xinput list-props ${MID} | sed -n 's/.*atural.*crolling.*nabled\s*(\([0-9]*\)).*/\1/p')

xinput --set-prop ${MID} ${MSEPROP} 1