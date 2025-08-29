# Manually install yay from AUR if not already available
if ! command -v yay &>/dev/null; then
  # Install build tools
  sudo pacman -Sy --needed --noconfirm base-devel
  cd /tmp
  rm -rf yay-bin
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  cd -
  rm -rf yay-bin
  cd ~
fi

# Set package manager based on architecture
if [ -n "$OMARCHY_ARM" ]; then
  PKG_MANAGER="yay"
else
  PKG_MANAGER="sudo pacman"
fi

$PKG_MANAGER -S --noconfirm --needed \
  pipewire-jack \
  alacritty \
  avahi \
  bash-completion \
  bat \
  blueberry \
  brightnessctl \
  btop \
  cargo \
  clang \
  cups \
  cups-browsed \
  cups-filters \
  cups-pdf \
  docker \
  docker-buildx \
  docker-compose \
  dust \
  evince \
  eza \
  fastfetch \
  fcitx5 \
  fcitx5-gtk \
  fcitx5-qt \
  fd \
  ffmpegthumbnailer \
  fzf \
  gcc14 \
  github-cli \
  gnome-calculator \
  gnome-keyring \
  gnome-themes-extra \
  gum \
  gvfs-mtp \
  hypridle \
  hyprland \
  hyprland-qtutils \
  hyprlock \
  hyprpicker \
  hyprshot \
  hyprsunset \
  imagemagick \
  impala \
  imv \
  inetutils \
  jq \
  kdenlive \
  kvantum-qt5 \
  lazydocker \
  lazygit \
  less \
  libqalculate \
  libreoffice \
  llvm \
  luarocks \
  mako \
  man \
  mariadb-libs \
  mise \
  mpv \
  nautilus \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra \
  nss-mdns \
  nvim \
  pamixer \
  pipewire-alsa \
  pipewire-pulse \
  playerctl \
  plocate \
  plymouth \
  polkit-gnome \
  postgresql-libs \
  power-profiles-daemon \
  python-gobject \
  python-poetry-core \
  ripgrep \
  satty \
  slurp \
  starship \
  sushi \
  swaybg \
  swayosd \
  system-config-printer \
  tldr \
  tree-sitter-cli \
  ttf-cascadia-mono-nerd \
  ttf-jetbrains-mono \
  ufw \
  unzip \
  uwsm \
  walker \
  waybar \
  wf-recorder \
  whois \
  wiremix \
  wireplumber \
  wl-clip-persist \
  wl-clipboard \
  wl-screenrec \
  woff2-font-awesome \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-hyprland \
  xmlstarlet \
  xournalpp \
  zoxide

if [ -z "$OMARCHY_ARM" ]; then
  $PKG_MANAGER -S --noconfirm --needed \
  1password-beta \
  1password-cli \
  localsend \
  obs-studio \
  obsidian \
  omarchy-chromium \
  pinta \
  python-terminaltexteffects \
  ufw-docker \
  signal-desktop \
  spotify \
  ttf-ia-writer \
  typora \
  tzupdate \
  walker-bin \
  wl-screenrec \
  yaru-icon-theme
fi
