#!/usr/bin/env bash

# source ~/.profile # just in case, because execution from vscode doesn't do it properly?

for F in "$@"; do
    OFILE="$(sed -rn 's/^(.*)(\.md)$/\1.pdf/p' <<<"${F}")"
    [[ -f "${OFILE}" ]] && mv "${OFILE}" "${OFILE}".bak
    set -x
    pandocomatic -b -c ~/.pandoc/pandocomatic/pandocomatic.yaml -o "${OFILE}" "${F}" 1>&2 && echo "${OFILE}"
    set +x
done
