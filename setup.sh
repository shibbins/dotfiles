#!/bin/bash

set -eu

cd "$(dirname "$0")"

echo "Installing prerequisites"
sudo $PWD/install_prerequisites.sh || echo "Failed to install prerequisites"; exit 1

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
)
for FILE in "${FILES[@]}"; do
  if [ -f "$FILE" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    echo "Backing up $FILE to $FILE.$TIMESTAMP"
    mv "$FILE" "$FILE".$TIMESTAMP
  fi
done

NVIM_CONF_DIR="${HOME}/.config/nvim"
if [ -d "${HOME}/.config/nvim" ]; then
  TIMESTAMP=$(date +%Y%m%d_%H%M%S)
  echo "Backing up neovim config to ${NVIM_CONF_DIR}_$TIMESTAMP"
  mv "${NVIM_CONF_DIR}" "${NVIM_CONF_DIR}_$TIMESTAMP"
fi

mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.vim/plugged

ln -s $PWD/aliases ~/.aliases
ln -s $PWD/bashrc ~/.bashrc
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/tmuxlightline ~/.tmuxlightline
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -s $PWD/.config/nvim/plugins/init.lua ~/.config/nvim/plugins/init.lua
for FILE in $(ls "$PWD/.config/nvim/lua/"); do
  echo "${NVIM_CONF_DIR}/lua/${FILE}"
  ln -s "$PWD/.config/nvim/lua/${FILE}" "${NVIM_CONF_DIR}/lua/${FILE}"
done

echo ""

# Install pure prompt
if [ ! -d "$HOME/.zsh/pure" ]; then
  echo "Installing Pure prompt"
  mkdir -p "$HOME/.zsh"
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# Install ZSH autosuggestions
if [ ! -d "$HOME/.zsh/zsh-autosuggestions" ]; then
  echo "Installing ZSH autosuggestions"
  mkdir -p "$HOME/.zsh"
  git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
fi

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TMUX plugin manager and plugins"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

# Install vim-plug for vim
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "Installing vim-plug"
  curl -sfLo ~/.vim/autoload/plug.vim \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install solarized8 theme for vim
if [ ! -f "$HOME/.vim/colors/solarized8.vim" ]; then
  echo "Installing vim colorscheme"
  curl -sfLo ~/.vim/colors/solarized8.vim \
    --create-dirs \
    https://raw.githubusercontent.com/lifepillar/vim-solarized8/master/colors/solarized8.vim
fi

nvim --headless "+Lazy! sync" +qa
vim +PlugInstall +qall
