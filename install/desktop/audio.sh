#!/bin/bash

# on macbook m-series we need pipewire
if [ -n "$OMARCHY_ARM" ]; then
  yay -S --needed --noconfirm pipewire-alsa pipewire-pulse wireplumber pipewire-jack asahi-audio
fi
