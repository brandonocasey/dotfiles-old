# shellcheck shell=sh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [ -n "$ZSH_VERSION" ] && [ -f "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#zmodload zsh/zprof


# ~~ Functions ~~
cmd_exists() {
  if command -v "$1" >/dev/null 2>&1; then
    return 0
  fi

  return 1
}

_add_to_pathvar() {
  # remove trailing slashes
  local pathvar="${1%%+(/)}"
  local dir="${2%%+(/)}"

  case ":${PATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) pathvar="$pathvar:$dir"  ;;
  esac


  printf '%s' "$pathvar"
}


path_add() {
  PATH="$(_add_to_pathvar "$PATH" "$1" "$2")"
}

manpath_add() {
  MANPATH="$(_add_to_pathvar "$MANPATH" "$1" "$2")"
}

infopath_add() {
  INFOPATH="$(_add_to_pathvar "$INFOPATH" "$1" "$2")"
}

fpath_add() {
  FPATH="$(_add_to_pathvar "$FPATH" "$1" "$2")"
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
  export HOMEBREW_PREFIX="$(brew --prefix)"
  # See https://docs.brew.sh/Analytics
  export HOMEBREW_NO_ANALYTICS=1
  path_add "$HOMEBREW_PREFIX/bin"
  path_add "$HOMEBREW_PREFIX/sbin"
  manpath_add "$HOMEBREW_PREFIX/share/man"
  infopath_add "$HOMEBREW_PREFIX/share/info"
  fpath_add "$HOMEBREW_PREFIX/share/zsh/site-functions/"
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
if [ -n "$SHELL_NAME" ]; then
  for file in "$DOTFILES_DIR"/shell/sh/* "$DOTFILES_DIR"/shell/"$SHELL_NAME"/* "$DOTFILES_DIR"/shell/plugins/*; do
    source "$file"
  done
else
  for file in "$DOTFILES_DIR"/shell/sh/* "$DOTFILES_DIR"/shell/plugins/*; do
    source "$file"
  done
fi
unset file

#zprof
