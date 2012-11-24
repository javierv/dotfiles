# source presto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

setopt nonomatch # Avoid "no matches found" with scp, sudo, and probably others.
setopt clobber # Overwrite existing files with > and >>.

# Use vi keybindings
bindkey 'ñ'     vi-cmd-mode

# Colors. Copied from prezto's utility module.
alias ls='ls --group-directories-first'

if zstyle -t ':prezto:module:utility:ls' color; then
  if [[ -s "$HOME/.dir_colors" ]]; then
    eval "$(dircolors "$HOME/.dir_colors")"
  else
    eval "$(dircolors)"
  fi

  alias ls="$aliases[ls] --color=auto"
else
  alias ls="$aliases[ls] -F"
fi

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

for extension in avi mp4 webm ogv; do
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

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
