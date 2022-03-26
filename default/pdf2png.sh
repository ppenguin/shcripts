#!/bin/bash

if [ -z "${1}" ]; then
    echo -e "Usage: $(basename ${0}) input.pdf [dpi]\n\t(dpi=200 if not specified)"
    exit 1
fi

PDF=${1}

if [ -z "$(file ${PDF} | grep PDF)" ]; then
    echo "File ${PDF} not recognised as pdf file!"
    exit 1
fi

DPI=${2:-200}
OUT=$(sed -e 's/\.pdf/\.png/gi' <<<${PDF})

gs -dNOPAUSE -q -r${DPI} -sDEVICE=pngalpha -dBATCH -sOutputFile="${OUT}" "${PDF}"