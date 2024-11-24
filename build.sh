#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# rpm-ostree install screen

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

# systemctl enable podman.socket

rpm-ostree install displaylink \
  mozilla-fira-sans-fonts \
  papirus-icon-theme \
  papirus-icon-theme-light \
  papirus-icon-theme-dark \
  epapirus-icon-theme \
  usbguard \
  usbguard-dbus \
  usbguard-tools \
  usbguard-selinux \
  telnet \
  nmap \
  netcat \
  efivar \
  efivar-libs

curl -sL https://api.github.com/repos/ryanoasis/nerd-fonts/tags \
  | jq -r '.[0].name' \
  | xargs -I {} curl -sL https://github.com/ryanoasis/nerd-fonts/releases/download/{}/FiraCode.zip -o /tmp/FiraCode.zip


mkdir -p /usr/share/fonts/fira-nf

unzip -o /tmp/FiraCode.zip -d /usr/share/fonts/fira-nf

rm -f /usr/share/fonts/fira-nf/{LICENSE,README.md} /tmp/FiraCode.zip /40-rpmostree-pkg-usermod-qemu-kvm.conf

fc-cache -f /usr/share/fonts/fira-nf

fc-cache --system-only --really-force --verbose

curl -sL https://ncastillo.xyz/wallpaper.png -o /usr/share/backgrounds/wallpaper.png

echo "Re-compiling gschema to include setting overrides"
glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null

curl -sL https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/refs/heads/master/papirus-folders -o /usr/bin/papirus-folders

chmod +x /usr/bin/papirus-folders

/usr/bin/papirus-folders -C violet --theme Papirus-Dark
/usr/bin/papirus-folders -C violet --theme Papirus
/usr/bin/papirus-folders -C violet --theme ePapirus