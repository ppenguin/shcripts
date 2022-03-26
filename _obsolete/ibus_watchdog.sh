#!/bin/sh

main () {
    while [ 1 ]; do
        L="$(top -bn1 | grep ibus-daemon | grep -v grep | awk '{ print $9 }')"
        [[ -z "${L}" ]] && L="0.0"
        if (( $(echo "${L} > 8.0" | bc -l) )); then
	    echo "$(date): restarting ibus daemon because load is too high (${L})..." >> ${HOME}/.ibus-watchdog.log
            ibus-daemon -drx --panel=/usr/lib/kimpanel-ibus-panel 
        fi
        sleep 10
    done
}

main &
