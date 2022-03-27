#!/usr/bin/env sh

# set monitor brightness and contrast for all DDC capable monitors

ND=$(ddcutil detect | awk '$0~/Display/ { print $2 }')

B=${1:-50}
C=${2:-50}

for N in ${ND}; do
    >&2 printf "Setting display %d:\n\tbrightness %d => %d\n\tcontrast %d => %d\n" \
        "${N}" \
        "$(ddcutil -d ${N} getvcp 10 | sed -nr 's/^.*current value =\s*([0-9]*).*$/\1/p')" \
        "${B}" \
        "$(ddcutil -d ${N} getvcp 12 | sed -nr 's/^.*current value =\s*([0-9]*).*$/\1/p')" \
        "${C}"
    ddcutil -d ${N} setvcp 10 ${B}
    ddcutil -d ${N} setvcp 12 ${C}
done