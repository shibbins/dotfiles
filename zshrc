# Local settings
[ -r ~/.zsh_local ] && source ~/.zsh_local


# Aliases
[ -f ~/.aliases ] && source ~/.aliases


# Exports
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export EDITOR="nvim"


# History
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=100000
SAVEHIST=100000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups 
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history


# Prompt
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt pure


# Auto completion
autoload -U compinit
zstyle ':completion::complete:*' use-cache 1

# Edit command line
autoload -U edit-command-line
zle -N edit-command-line

# Key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
KEYTIMEOUT=20


# Misc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PATH=$PATH:~/go/bin
