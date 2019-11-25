autoload -Uz promptinit && promptinit
prompt sorin


##### PLUGINS #####
source "$HOME/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.zsh/history-substring-search/zsh-history-substring-search.zsh"
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"


##### SHORTCUTS #####
# Use similar shortcuts for substring matching
bindkey -M emacs '\C-k' history-substring-search-up
# bindkey -M emacs '\C-j' history-substring-search-down # Can't bind C-j
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# Use mixed emacs-vi keybindings
bindkey -e
bindkey 'ñ' vi-cmd-mode

# Use shortcuts to handle autosuggestions
bindkey '^@' autosuggest-accept # Ctrl-space
bindkey '^J' autosuggest-accept # Shift-enter
# Can't use Ctrl-Enter because my terminal doesn't distinguish it from Enter.
bindkey '^F' autosuggest-execute

##### HISTORY #####
# Lines of history to keep in ~/.zhistory:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zhistory

setopt inc_append_history  # Write to the history file immediately
setopt share_history       # Share history between open sessions.
setopt hist_ignore_dups    # Don't save commands repeated *in a row*.
setopt hist_ignore_space   # Don't save commands starting with space.
setopt hist_find_no_dups   # Don't find repeated commands.

##### DIRECTORIES #####
setopt auto_cd        # Changes directory without typing cd.
setopt extended_glob  # Allows '~' in the prompt instead of './~'


##### COLORS #####
alias ls='ls --group-directories-first'
eval "$(dircolors)"
alias ls="$aliases[ls] --color=auto"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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
alias gg='git gui &'
alias apt-search='apt-cache search'
alias apt-show='apt-cache show'
alias apt-install='apt-get install'
alias sudo='sudo '
alias p='mpcplay'
alias q='mpcqueue'

function sb() {
  rails c $1 --sandbox
}

function cdr() {
  cd "$(git rev-parse --show-toplevel)"
}

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi


##### FILE EXTENSIONS #####
for extension in jpg png jpeg gif; do
	alias -s $extension=gwenview
done

for extension in avi mp4 webm ogv mkv; do
  alias -s $extension=dragon
done

for extension in txt erb haml markdown yml; do
  alias -s $extension=vim
done

for extension in epub pdf; do
  alias -s $extension=okular
done


##### COMPLETION #####
autoload -Uz compinit; compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt case_glob

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Color file completions

# Use caching to make completion for cammands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"

# Show a message for no matches.
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# Group completions, like "commands", "aliases", "directories in cdpath".
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'

# Paginate completions, like options for ls.
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,user,comm'
zstyle ':completion:*:*:kill:*' insert-ids single


##### MISC #####
setopt nonomatch # Avoid "no matches found" with scp, sudo, and probably others.
stty -ixon # No controlar flujo con ctrl-s y ctrl-q.
autoload -U zmv zcalc
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Suggest packages to install
if [[ -s '/etc/zsh_command_not_found' ]]; then
  source '/etc/zsh_command_not_found'
fi

# Source local configuration.
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
