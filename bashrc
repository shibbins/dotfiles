# Test for an interactive shell.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Exports
export EDITOR="nvim"
export VISUAL="nvim"


# History
export HISTFILE=~/.bash_history
export HISTSIZE=100000
export HISTFILESIZE=100000


# Key bindings
set -o vi
bind '"jk":vi-movement-mode'


# Misc
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH=$PATH:~/go/bin
