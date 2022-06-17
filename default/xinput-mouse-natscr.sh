#!/usr/bin/env sh

MIDS=$(xinput list | sed -n 's/.*[Mm]*ouse.*id=\([0-9]*\).*/\1/p')

for MID in ${MIDS}; do
    MSEPROP=$(xinput list-props ${MID} | sed -n 's/.*atural.*crolling.*nabled\s*(\([0-9]*\)).*/\1/p')
    [[ -n "${MSEPROP}" ]] && {
        xinput --set-prop ${MID} ${MSEPROP} 1
        printf "Set prop:\n%s\n\tof device\n\t%s to 1\n" \
            "$(xinput list-props ${MID} | awk '/'"${MSEPROP}"'/ { print substr($0,0,(index($0,":")-1)) }')" \
            "$(xinput list ${MID} | awk '/id='"${MID}"'/ { print substr($0,0,(index($0,"[")-1)) }')"
    }
done