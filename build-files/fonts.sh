#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

curl -sL https://api.github.com/repos/ryanoasis/nerd-fonts/tags \
  | jq -r '.[0].name' \
  | xargs -I {} curl -sL https://github.com/ryanoasis/nerd-fonts/releases/download/{}/FiraCode.zip -o /tmp/FiraCode.zip


mkdir -p /usr/share/fonts/fira-nf

unzip -o /tmp/FiraCode.zip -d /usr/share/fonts/fira-nf

rm -f /usr/share/fonts/fira-nf/{LICENSE,README.md} /tmp/FiraCode.zip /40-rpmostree-pkg-usermod-qemu-kvm.conf

fc-cache -f /usr/share/fonts/fira-nf

fc-cache --system-only --really-force --verbose
