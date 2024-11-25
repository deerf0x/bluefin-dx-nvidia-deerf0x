#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

curl -sL https://ncastillo.xyz/wallpaper.png -o /usr/share/backgrounds/wallpaper.png

echo "Re-compiling gschema to include setting overrides"
glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null

/usr/bin/papirus-folders -C violet --theme Papirus-Dark
/usr/bin/papirus-folders -C violet --theme Papirus
/usr/bin/papirus-folders -C violet --theme ePapirus