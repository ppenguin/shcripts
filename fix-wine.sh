#!/usr/bin/env bash

WEXE=$(command -v wine64)
WEXE=${WEXE:-$(command -v wine)}
if [ -z "${WEXE}" ]; then
    echo "FATAL: no wine executable found"
    exit 1
fi
TMPREG=$(mktemp)

cleanup() {
    rm -f "${TMPREG}" # just in case
}
trap cleanup EXIT

# set dpi to 220
# https://forum.winehq.org/viewtopic.php?t=34980
setdpi() {
    ${WEXE} reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v LogPixels /t REG_DWORD /d 0xdc /f
}

# set dark theme (breeze) for wine
# https://gist.github.com/Zeinok/ceaf6ff204792dde0ae31e0199d89398
settheme() {
cat << 'EOF' > ${TMPREG}
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\Colors]
"ActiveBorder"="49 54 58"
"ActiveTitle"="49 54 58"
"AppWorkSpace"="60 64 72"
"Background"="49 54 58"
"ButtonAlternativeFace"="200 0 0"
"ButtonDkShadow"="154 154 154"
"ButtonFace"="49 54 58"
"ButtonHilight"="119 126 140"
"ButtonLight"="60 64 72"
"ButtonShadow"="60 64 72"
"ButtonText"="219 220 222"
"GradientActiveTitle"="49 54 58"
"GradientInactiveTitle"="49 54 58"
"GrayText"="155 155 155"
"Hilight"="119 126 140"
"HilightText"="255 255 255"
"InactiveBorder"="49 54 58"
"InactiveTitle"="49 54 58"
"InactiveTitleText"="219 220 222"
"InfoText"="159 167 180"
"InfoWindow"="49 54 58"
"Menu"="49 54 58"
"MenuBar"="49 54 58"
"MenuHilight"="119 126 140"
"MenuText"="219 220 222"
"Scrollbar"="73 78 88"
"TitleText"="219 220 222"
"Window"="35 38 41"
"WindowFrame"="49 54 58"
"WindowText"="219 220 222"
EOF
${WEXE} regedit "${TMPREG}"
rm -f "${TMPREG}"
}

# main
setdpi
settheme