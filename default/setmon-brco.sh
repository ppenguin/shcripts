#!/usr/bin/env sh

# set monitor brightness and contrast for all DDC capable monitors

DDC="ddcutil --sleep-multiplier=0.1"
ND=$(${DDC} detect | awk '$0~/Display/ { print $2 }')

B=${1:-50}
C=${2:-50}

for N in ${ND}; do
    >&2 printf "Setting display %d:\n\tbrightness %d => %d\n\tcontrast %d => %d\n" \
        "${N}" \
        "$(${DDC} -d ${N} getvcp 10 | sed -nr 's/^.*current value =\s*([0-9]*).*$/\1/p')" \
        "${B}" \
        "$(${DDC} -d ${N} getvcp 12 | sed -nr 's/^.*current value =\s*([0-9]*).*$/\1/p')" \
        "${C}"
    ${DDC} -d ${N} setvcp 10 ${B}
    ${DDC} -d ${N} setvcp 12 ${C}
done