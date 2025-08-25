#!/bin/bash

if [ -n "$OMARCHY_ARM" ]; then
  yay -S --needed --noconfirm pipewire-alsa pipewire-pulse wireplumber pipewire-jack
fi
