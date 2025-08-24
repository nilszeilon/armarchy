#!/bin/bash

# Prerequisites for installing Omarchy on a m-series macbook
#
# 1. Follow these instructions: https://asahi-alarm.org/
# 2. choose the minimal installation.
# 3. Set up wifi and install wget
# 4. Run the omarchy install command

# Asahi Linux ARM setup script for Omarchy
# This script automates the post-Asahi installation steps for MacBook M-series

# Check if we're on Asahi Linux and need initial setup
if [ "$EUID" -eq 0 ] && [ "$(uname -m)" = "aarch64" ]; then
  # Check for Asahi indicators
  if grep -qi "asahi" /etc/os-release 2>/dev/null ||
    uname -r | grep -qi "asahi" ||
    pacman -Q linux-asahi &>/dev/null ||
    pacman -Q asahi-scripts &>/dev/null; then
    echo "Detected Asahi Linux - running initial setup..."
    # using exec instead of source to continue the installation after switching user

    set -e

    # Check if running as root (required for initial setup)
    if [ "$EUID" -ne 0 ]; then
      echo "This script must be run as root for initial setup"
      echo "Please run: sudo bash $0"
      exit 1
    fi

    echo "=================================="
    echo "Omarchy Asahi Linux Setup"
    echo "=================================="
    echo

    # Check if user already exists
    echo "Setting up user account..."
    existing_users=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd)

    if [ -n "$existing_users" ]; then
      echo "Found existing users: $existing_users"
      use_existing=$(gum confirm "Use an existing user account?" && echo "yes" || echo "no")

      if [ "$use_existing" = "yes" ]; then
        username=$(echo "$existing_users" | gum choose --header "Select user:")
      else
        username=$(gum input --placeholder "Enter new username")
      fi
    else
      username=$(gum input --placeholder "Enter username for Omarchy")
    fi

    # Create user if doesn't exist
    if ! id "$username" &>/dev/null; then
      echo "Creating user $username..."
      useradd -m "$username"

      echo "Setting password for $username..."
      while true; do
        password=$(gum input --password --placeholder "Enter password for $username")
        password_confirm=$(gum input --password --placeholder "Confirm password")

        if [ "$password" = "$password_confirm" ]; then
          echo "$username:$password" | chpasswd
          break
        else
          echo "Passwords don't match. Please try again."
        fi
      done

      # Add to wheel group for sudo access
      usermod -aG wheel "$username"
      echo "Added $username to wheel group"
    fi

    # Enable sudo for wheel group
    echo "Configuring sudo access..."
    if grep -q "^# %wheel ALL=(ALL:ALL) ALL" /etc/sudoers; then
      sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
      echo "Enabled sudo for wheel group"
    elif ! grep -q "^%wheel ALL=(ALL:ALL) ALL" /etc/sudoers; then
      echo "%wheel ALL=(ALL:ALL) ALL" >>/etc/sudoers
      echo "Added wheel group to sudoers"
    fi

    # User setup complete - provide instructions for continuing
    echo
    echo "=================================="
    echo "Initial setup complete!"
    echo "=================================="
    echo
    echo "Please follow these steps to continue:"
    echo
    echo "1. Exit this root session (type 'exit' or press Ctrl+D)"
    echo "2. Log in as user: $username"
    echo "3. Run the following command to continue installation:"
    echo
    echo "   wget -qO- https://omarchy.org/install | bash"
    echo
    echo "Or for testing with the GitHub repo:"
    echo "   wget -qO- https://raw.githubusercontent.com/nilszeilon/armarchy/master/boot.sh | bash"
    echo
    echo "=================================="
    echo
    
    # Exit the script here so it doesn't continue with the rest of install.sh
    exit 0

  fi
fi
