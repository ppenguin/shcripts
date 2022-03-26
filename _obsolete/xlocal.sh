#! /usr/bin/env bash

sudo systemctl stop xrdp && systemctl stop xrdp-sesman && sudo systemctl restart sddm 
