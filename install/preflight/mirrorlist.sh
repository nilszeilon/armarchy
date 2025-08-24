#!/bin/bash
# Add geo mirror to the top of mirrorlist
if ! grep -q "geo.mirror.pkgbuild.com" /etc/pacman.d/mirrorlist 2>/dev/null; then
  echo 'Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch' |
    sudo tee /tmp/mirrorlist.tmp >/dev/null
  sudo cat /etc/pacman.d/mirrorlist >>/tmp/mirrorlist.tmp
  sudo mv /tmp/mirrorlist.tmp /etc/pacman.d/mirrorlist
fi

# Update indexes if online
if ping -c5 omarchy.org &>/dev/null; then
  sudo pacman -Syy
fi
