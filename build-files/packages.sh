#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

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