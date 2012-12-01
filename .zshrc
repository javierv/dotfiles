# source presto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


##### COLORS #####
alias ls='ls --group-directories-first'
eval "$(dircolors)"
alias ls="$aliases[ls] --color=auto"

# 256 colors
if [[ $TMUX = '' ]]; then
  export TERM=xterm-256color
else
  export TERM=screen-256color
fi


###### ALIASES #####
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


##### FILE EXTENSIONS #####
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


##### MISC #####
# Use mixed emacs-vi keybindings
bindkey 'ñ' vi-cmd-mode

setopt nonomatch # Avoid "no matches found" with scp, sudo, and probably others.
setopt clobber # Overwrite existing files with > and >>.

# Source local configuration.
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
