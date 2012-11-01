# source presto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Easier cd
CDPATH=:$HOME/dev
setopt auto_cd

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

# colors for ls and grep
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# aliases for frequently typed commands
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

autoload -U zmv zcalc

# Use modern completion system
autoload -Uz compinit; compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
