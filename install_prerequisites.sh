#!/bin/bash

set -eu

apt-get update

apt-get install -qq -y \
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
	zsh
