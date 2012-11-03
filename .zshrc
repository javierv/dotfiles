# source presto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

CDPATH=:$HOME/dev

setopt histignorealldups sharehistory
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use vi keybindings
bindkey 'ñ'     vi-cmd-mode

# Mimic emacs while on insert mode
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history
bindkey "^R" history-incremental-search-backward

# aliases for frequently typed commands
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias q='exit'
alias gg='git gui &'
alias apt-search='apt-cache search'
alias apt-show='apt-cache show'
alias apt-install='apt-get install'
alias sudo='sudo '

function sb() {
  rails c $1 --sandbox
}

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# aliases for file extensions
for extension in jpg png jpeg gif; do
	alias -s $extension=gwenview
done

for extension in avi mp4 webm; do
  alias -s $extension=mplayer
done

for extension in rb txt erb haml markdown yml; do
  alias -s $extension=vim
done

for extension in epub pdf; do
  alias -s $extension=okular
done


# 256 colors
if [[ $TMUX = '' ]]; then
  export TERM=xterm-256color
else
  export TERM=screen-256color
fi

if [ -f ~/.zsh.local ]; then
	source ~/.zsh.local
fi
