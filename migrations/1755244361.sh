# Add state for arm achitecture
if [[ $(uname -m) == "arm"* || $(uname -m) == "aarch64" || -n "$OMARCHY_ARM" ]]; then
  # Do something for ARM
  echo "Running on ARM architecture"

  mkdir -p ~/.local/state/omarchy
  touch ~/.local/state/omarchy/arm.mode
fi
