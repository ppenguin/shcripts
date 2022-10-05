#!/usr/bin/env bash

# set monitor brightness and contrast for all DDC capable monitors
# TODO: mplement: from ddcutil 1.3.0 getvcp supports multiple feature codes (which may speedup execution)

DDC="ddcutil --sleep-multiplier=0.3 --brief"
ND=$(${DDC} detect | awk '$0~/Display/ { print $2 }')

B=${1:-50}
C=${2:-${B}}

# getincorabs <value> <increment_or_absolute>
# does not check for incorrect format!
getincorabs() {
    case ${2} in
        -*|+*)
            echo "$((${1}${2}))"
            ;;
        *)
            echo "${2}"
            ;;
    esac
}

# getvcp <displaynr> <feature> returns int value of the feature
getvcp() {
    ${DDC} -d "${1}" getvcp "${2}" | awk '{ print $4 }'
}

# setvcp <displaynr> <feature> <tgtvalue> returns <tgtvalue>
setvcp() {
    ${DDC} -d "${1}" setvcp "${2}" "${3}" 1>&2
    echo "${3}"
}

# getsetvcp <displaynr> <feature> <tgtvalue> returns old and new value
getsetvcp() {
    curval=$(getvcp "${1}" "${2}")
    tgtval=$(getincorabs "${curval}" "${3}")
    res=$(setvcp "${1}" "${2}" "${tgtval}")
    echo "${curval} ${res}"
}

# setbrightness <displaynr> <incr_or_abs>
setbrightness() {
    printf "display %s brightness %s -> %s\n" ${1} $(getsetvcp ${1} 10 ${2}) >&2
}

# setbrightness <displaynr> <incr_or_abs>
setcontrast() {
    printf "display %s contrast %s -> %s\n" ${1} $(getsetvcp ${1} 12 ${2}) >&2
}

# setbrco <displaynr> <br> [<co>]
# set both brightness and contrast with the same value if contrast is not given
setbrco() {
    disp=${1}
    br=${2}
    if [ -n "${3}" ]; then
        co=${3}
    else
        co=${2}
    fi;
    setbrightness ${disp} ${br}
    setcontrast ${disp} ${co}
}

# different monitors async (with &) didn't work...
for N in ${ND}; do
    setbrco ${N} ${B} ${C}
done