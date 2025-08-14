#!/bin/bash

if [ -z "$OMARCHY_ARM" ]; then
  yay -S --noconfirm --needed \
    cargo clang llvm mise \
    imagemagick \
    mariadb-libs postgresql-libs \
    github-cli \
    lazygit lazydocker-bin
else
  yay -S --noconfirm --needed \
    cargo clang llvm mise \
    imagemagick \
    mariadb-libs postgresql-libs \
    github-cli \
    lazygit lazydocker
fi
