# shellcheck shell=sh

# ~~ Functions ~~
cmd_exists() {
  if command -v "$1" >/dev/null 2>&1; then
    return 0
  fi

  return 1
}

_add_to_pathvar() {
  # remove trailing slashes
  pathvar="${1%%+(/)}"
  dir="${2%%+(/)}"
  unshift="$3"

  # no path exists, just add the binary path
  if [ -n "$pathvar" ]; then
    # already in path
    old_ifs="$IFS"
    IFS=:

    for p in $pathvar; do
      [ "$p" = "$dir" ] && IFS="$old_ifs" && return
    done

    IFS="$old_ifs"

    # by default we push to the end
    if [ -z "$unshift" ]; then
      pathvar="$PATH:$dir"
    else
      pathvar="$dir:$PATH"
    fi

    unset unshift
    unset old_ifs
  else
    pathvar="$dir"
  fi

  printf '%s' "$pathvar"
  unset pathvar
  unset dir
  unset unshift
}


path_add() {
  PATH="$(_add_to_pathvar "$PATH" "$1" "$2")"
  export PATH
}

manpath_add() {
  MANPATH="$(_add_to_pathvar "$MANPATH" "$1" "$2")"
  export MANPATH
}

infopath_add() {
  INFOPATH="$(_add_to_pathvar "$INFOPATH" "$1" "$2")"
  export MANPATH
}

fpath_add() {
  FPATH="$(_add_to_pathvar "$FPATH" "$1" "$2")"
  export FPATH
}

# ~~ Shared Exports ~~
if [ -n "$ZSH_VERSION" ]; then
  export SHELL_NAME="zsh"
elif [ -n "$BASH_VERSION" ]; then
  export SHELL_NAME="bash"
fi

UNAME="$(uname)"

# TODO: Windows?
if [ "$UNAME" = "Darwin" ]; then
  export OS_NAME="mac"
elif [ "$UNAME" = "Linux" ]; then
  export OS_NAME="linux"
fi

unset UNAME

if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi


if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ -z "$XDG_STATE_HOME" ]; then
  export XDG_STATE_HOME="$HOME/.local/state"
fi

if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

if [ -z "$XDG_RUNTIME_DIR" ]; then
  if [ "$OS_NAME" = 'mac' ]; then
    export XDG_RUNTIME_DIR="$HOME/Library/Application Support"
  elif [ "$OS_NAME" = 'linux' ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  fi
fi

export DOTFILES_DIR="$XDG_CONFIG_HOME/dotfiles"

# ~~ PATH ~~
# PATH Priority is
# $HOME -> $DOTFILES_DIR -> (Homebrew if exists) -> global
path_add "/usr/local/bin"
path_add "/usr/bin"
path_add "/bin"
path_add "/usr/sbin"
path_add "/sbin"
path_add "./vendor/bin"
path_add "./bin"
path_add "./node_modules/.bin"
path_add "../node_modules/.bin"
path_add "../../node_modules/.bin"
path_add "../../../node_modules/.bin"
path_add "$HOME/.cargo/bin"
path_add "/usr/local/sbin"
manpath_add "/usr/share/man"
manpath_add "/usr/local/share/man"

if cmd_exists "brew"; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  export HOMEBREW_PREFIX
  path_add "$HOMEBREW_PREFIX/bin"
  path_add "$HOMEBREW_PREFIX/sbin"
  manpath_add "$HOMEBREW_PREFIX/share/man"
  infopath_add "$HOMEBREW_PREFIX/share/info"
fi

path_add "$DOTFILES_DIR/bin"
manpath_add "$DOTFILES_DIR/man"
infopath_add "$DOTFILES_DIR/info"
fpath_add "$DOTFILES_DIR/fn"
path_add "$HOME/bin"
manpath_add "$HOME/man"
infopath_add "$HOME/info"
fpath_add "$HOME/fn"

# ~~ main ~~
source_dir() {
  for file in "$DOTFILES_DIR"/shell/"$1"/*; do
    source "$file"
  done
  unset file
}

source_dir sh
source_dir plugins
if [ "$1" != '--no-shell' ] && [ -n "$SHELL_NAME" ]; then
  source_dir "$SHELL_NAME"
fi

unset -f source_dir
