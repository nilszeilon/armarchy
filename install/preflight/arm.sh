# Auto-detect ARM architecture and set flags
arch=$(uname -m)
if [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
  export OMARCHY_ARM=true
  export OMARCHY_BARE=true
  echo "Auto-detected ARM architecture: $arch"
  echo "Setting OMARCHY_ARM=true and OMARCHY_BARE=true"

  mkdir -p ~/.local/state/omarchy
  touch ~/.local/state/omarchy/arm.mode

  # make use of the right shaders for walker to work correctly
  echo "env = VK_ICD_FILENAMES,/usr/share/vulkan/icd.d/lvp_icd.aarch64.json" >>~/.config/hypr/envs.conf

  # ARM/aarch64 architecture needs its own config file for excluded apps
  ln -sf ~/.local/share/omarchy/default/hypr/aarch64_apps.conf ~/.local/share/omarchy/default/hypr/apps.conf
fi
