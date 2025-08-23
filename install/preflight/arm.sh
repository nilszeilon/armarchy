# Auto-detect ARM architecture and set flags
arch=$(uname -m)
if [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
  export OMARCHY_ARM=true
  export OMARCHY_BARE=true
  echo "Auto-detected ARM architecture: $arch"
  echo "Setting OMARCHY_ARM=true and OMARCHY_BARE=true"
fi
