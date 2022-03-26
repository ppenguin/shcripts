#! /usr/bin/env bash

killall startplasma-x11 kwin_x11
sleep 2
killall -9 startplasma-x11 kwin_x11
sudo systemctl stop sddm && sudo systemctl restart xrdp && systemctl restart xrdp-sesman
