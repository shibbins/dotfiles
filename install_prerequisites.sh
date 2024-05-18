#!/bin/bash

set -eu

install_macos_packages() {
  echo "Installing MacOS packages with homebrew"
  which brew >/dev/null && {
    packages=(
      bat
      curl
      fd
      fzf
      git
      git-delta
      neovim
      ripgrep
      tmux
      vim
    )
    brew install "${packages[@]}"
    exit 0
  }
}

install_linux_packages() {
  packages=(
    bat
    curl
    fd-find
    fzf
    git
    git-delta
    neovim
    ripgrep
    tmux
    vim
    xsel
    zsh
  )

  # Fedora/RHEL
  which dnf >/dev/null && {
    echo "Installing Linux packages with dnf"
    dnf install --refresh -y "${packages[@]}"
    exit 0
  }
  # Debian based distros
  which apt >/dev/null && {
    echo "Installing Linux packages with apt"
    apt-get update
    apt-get install -qq -y "${packages[@]}"
    exit 0
  }
}

# Check for supported operating systems.
case "$(uname -sr)" in
Darwin*)
  echo 'OS detected: MacOS'
  install_macos_packages
  ;;
Linux*)
  echo 'OS detected: Linux'
  install_linux_packages
  ;;
*)
  echo 'Unsupported OS'
  exit 1
  ;;
esac
