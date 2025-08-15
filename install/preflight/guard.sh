#!/bin/bash

abort() {
  echo -e "\e[31mOmarchy install requires: $1\e[0m"
  echo
  gum confirm "Proceed anyway on your own accord and without assistance?" || exit 1
}

# Must be an Arch distro
[[ -f /etc/arch-release ]] || abort "Vanilla Arch"

# Must not be an Arch derivative distro
for marker in /etc/cachyos-release /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
  [[ -f "$marker" ]] && abort "Vanilla Arch"
done

# Must not be runnig as root
[ "$EUID" -eq 0 ] && abort "Running as user (not root)"

# Must be x86 only to fully work, or ARM if OMARCHY_ARM is set
if [ -z "$OMARCHY_ARM" ]; then
  [ "$(uname -m)" != "x86_64" ] && abort "x86_64 CPU"
else
  arch=$(uname -m)
  [[ "$arch" != "aarch64" && "$arch" != "arm64" ]] && abort "ARM CPU"
fi

# if we install on m1 or m2 macbook then we should install BARE
if [ -n "$OMARCHY_ARM" ]; then
  export OMARCHY_BARE=true
fi

# Must not have Gnome or KDE already install
pacman -Qe gnome-shell &>/dev/null && abort "Fresh + Vanilla Arch"
pacman -Qe plasma-desktop &>/dev/null && abort "Fresh + Vanilla Arch"

# Cleared all guards
echo "Guards: OK"
