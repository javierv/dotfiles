cdpath=(
  $cdpath
  $HOME/dev
)

path=(
  /usr/local/{bin,sbin}
  /usr/{bin,sbin,games}
  /usr/bin/X11
  /{bin,sbin}
  $path
)

if [ -d "$HOME/bin" ] ; then
  path+=("$HOME/bin")
fi

if [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
  path+=("$HOME/.rbenv/bin")
  eval "$(rbenv init - zsh)"
fi

fpath=("$HOME/.zsh/completions/src" "$HOME/.zsh/themes" $fpath)
