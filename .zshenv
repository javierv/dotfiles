cdpath=(
  $cdpath
  $HOME/dev
)

path=(
  /usr/local/{bin,sbin}
  /usr/{bin,sbin,games}
  /usr/bin/X11
  /{bin,sbin}
)

if [ -d "$HOME/bin" ] ; then
  path+=("$HOME/bin")
fi

if [ -d "$HOME/n" ] ; then
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
fi

if [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
  path=(
    "$HOME/.rbenv/bin"
    "$HOME/.rbenv/shims"
    $path
  )
  eval "$(rbenv init - zsh)"
fi

fpath=("$HOME/.zsh/completions/src" "$HOME/.zsh/themes" $fpath)
