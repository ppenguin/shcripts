#!/bin/env zsh
set -uo pipefail

printf "Running pacman update...\n"
sudo pacman -Syu;

printf "Removing orphans...\\n"
sudo pacman -Rns $(pacman -Qtdq)

sudo pacdiff