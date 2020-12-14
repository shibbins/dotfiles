#!/bin/bash

set -eu

cd "$(dirname "$0")"

echo "Installing prerequisites"
sudo $PWD/install_prerequisites.sh

echo ""
echo "Prerequisites installed"


echo ""
echo "Backing up files"
FILES=(
    "${HOME}/.aliases"
    "${HOME}/.bashrc"
    "${HOME}/.tmux.conf"
    "${HOME}/.tmuxlightline"
    "${HOME}/.vimrc"
    "${HOME}/.zshrc"
    "${HOME}/.config/nvim/init.vim"
)
for FILE in "${FILES[@]}"; do
	if [ -f "$FILE" ]; then
		echo "Backing up $FILE to $FILE.old"
    		mv "$FILE" "$FILE".old
	fi
done


mkdir -p ~/.config/nvim/colors
mkdir -p ~/.vim/plugged

ln -s $PWD/aliases ~/.aliases
ln -s $PWD/bashrc ~/.bashrc
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/tmuxlightline ~/.tmuxlightline
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/vimrc ~/.config/nvim/init.vim
ln -s $PWD/zshrc ~/.zshrc

echo ""


# Install pure prompt
if [ ! -d "$HOME/.zsh/pure" ]; then
	echo "Installing Pure prompt"
	mkdir -p "$HOME/.zsh"
	git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	echo "Installing TMUX plugin manager"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install vim-plug for vim
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
	echo "Installing VIM plug"
	curl -sfLo ~/.vim/autoload/plug.vim \
	--create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install vim-plug for neovim
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
	echo "Installing VIM plug for neovim"
	sh -c 'curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
	--create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Install solarized8 theme for neovim
if [ ! -f "$HOME/.config/nvim/colors/solarized8.vim" ]; then
	echo "Installing neovim colorscheme"
	curl -sfLo ~/.config/nvim/colors/solarized8.vim \
	--create-dirs \
	https://raw.githubusercontent.com/lifepillar/vim-solarized8/master/colors/solarized8.vim
fi

# Install solarized8 theme for vim
if [ ! -f "$HOME/.vim/colors/solarized8.vim" ]; then
	echo "Installing vim colorscheme"
	curl -sfLo ~/.vim/colors/solarized8.vim \
	--create-dirs \
	https://raw.githubusercontent.com/lifepillar/vim-solarized8/master/colors/solarized8.vim
fi
