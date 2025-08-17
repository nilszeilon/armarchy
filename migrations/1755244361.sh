# Add state for arm achitecture
if [[ $(uname -m) == "arm"* || $(uname -m) == "aarch64" || -n "$OMARCHY_ARM" ]]; then
  mkdir -p ~/.local/state/omarchy
  touch ~/.local/state/omarchy/arm.mode
fi
