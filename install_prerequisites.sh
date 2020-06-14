#!/bin/bash

set -eu

apt-get update

apt-get install -qq -y \
	curl \
	git \
	neovim \
	nodejs \
	npm \
	ripgrep \
	tmux \
	vim \
	xsel \
	zsh
