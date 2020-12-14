# Aliases
[ -f ~/.aliases ] && source ~/.aliases


# Exports
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="nvim"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --smart-case --glob "!{.git,.hg}/*" 2> /dev/null'
export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude ".git" --exclude ".hg"'

if type fdfind &> /dev/null; then
	export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude ".git" --exclude ".hg"'
fi


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
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure


# Auto completion
autoload -U compinit
zstyle ':completion::complete:*' use-cache 1

# Edit command line
autoload -U edit-command-line
zle -N edit-command-line

# Fancy Ctrl-z
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z


# Key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^z' fancy-ctrl-z
KEYTIMEOUT=20

# Enable Emacs bindings when in insert mode
bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^a'  beginning-of-line
bindkey -M viins '^b'  backward-char
bindkey -M viins '^d'  delete-char-or-list
bindkey -M viins '^e'  end-of-line
bindkey -M viins '^f'  forward-char
bindkey -M viins '^g'  send-break
bindkey -M viins '^h'  backward-delete-char
bindkey -M viins '^k'  kill-line
bindkey -M viins '^n'  down-line-or-history
bindkey -M viins '^p'  up-line-or-history
bindkey -M viins '^r'  history-incremental-pattern-search-backward
bindkey -M viins '^u'  backward-kill-line
bindkey -M viins '^w'  backward-kill-word
bindkey -M viins '^y'  yank


# Misc
[ -f ~/zsh-vi-search.zsh ] && source ~/zsh-vi-search.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:~/go/bin

# Local settings
[ -r ~/.zsh_local ] && source ~/.zsh_local
