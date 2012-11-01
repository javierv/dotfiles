# source presto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
CDPATH=:$HOME/dev

# Set up the prompt
PROMPT='%n@%m:%~> '

setopt histignorealldups sharehistory
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use vi keybindings
bindkey -v
bindkey "^[[1~" vi-beginning-of-line   # Home
bindkey "^[[4~" vi-end-of-line         # End
bindkey '^[[2~' beep                   # Insert
bindkey '^[[3~' delete-char            # Del
bindkey '^[[5~' vi-backward-blank-word # Page Up
bindkey '^[[6~' vi-forward-blank-word  # Page Down
bindkey 'ñ'     vi-cmd-mode

# Change cursor shape in different vi modes.
zle-keymap-select () {
  if [ $KEYMAP = vicmd ]; then
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]50;CursorShape=0\x7"
    fi
  else
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]50;CursorShape=1\x7"
    fi
  fi
}

# Mimic emacs while on insert mode
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history
bindkey "^R" history-incremental-search-backward

# Make Home and End keys work in insert mode.
function zle-line-init () {
  echoti smkx
  zle -K viins
  # Make default cursor as insert mode
  if [[ $TMUX = '' ]]; then
    echo -ne "\033]50;CursorShape=1\x7"
  fi
}
function zle-line-finish () {
  echoti rmkx
}
zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish

# aliases for frequently typed commands
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias q='exit'
alias gg='git gui &'
alias apt-search='apt-cache search'
alias apt-show='apt-cache show'
alias apt-install='apt-get install'

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
