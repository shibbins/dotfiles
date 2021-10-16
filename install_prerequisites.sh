#!/bin/bash

set -eu

# Fedora/RHEL
which dnf >/dev/null && {
  dnf install -y \
    bat \
    curl \
    fd-find \
    git \
    neovim \
    nodejs \
    npm \
    ripgrep \
    tmux \
    vim \
    xsel \
    zsh;
  exit 0;
}

# Debian based distros
which apt >/dev/null && {
  apt-get update

  apt-get install -qq -y \
    bat \
    curl \
    fd-find \
    git \
    neovim \
    nodejs \
    npm \
    ripgrep \
    tmux \
    vim \
    xsel \
    zsh;
  exit 0;
}
