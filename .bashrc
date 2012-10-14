# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# enable color support of ls and also add handy aliases
eval `dircolors -b`
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# set a fancy prompt
PS1='\u@\h:\w\$ '

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# Make Control-v paste, if in X and if xclip available - Josh Triplett
if [ -n "$DISPLAY" ] && [ -x /usr/bin/xclip ] ; then
  # Work around a bash bug: \C-@ does not work in a key binding
  bind '"\C-x\C-m": set-mark'
  # The '#' characters ensure that kill commands have text to work on; if
  # not, this binding would malfunction at the start or end of a line.
  bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -o -selection c)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
fi

# 256 colors
# export TERM=screen-256color

# Load tmux on startup
if [ "$TERM" != "screen-256color" ] && [ -x /usr/bin/tmux ]
then
  export TERM=screen-256color
  tmux attach || tmux new
fi
