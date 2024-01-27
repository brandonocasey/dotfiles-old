# shellcheck shell=bash

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

export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

if [ -z "$XDG_RUNTIME_DIR" ]; then
  if [ "$OS_NAME" = 'mac' ]; then
    export XDG_RUNTIME_DIR="$HOME/Library/Application Support"
  elif [ "$OS_NAME" = 'linux' ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  fi
fi

export HOMEBREW_PREFIX
if cmd_exists brew; then
  if [ -f "$DOTFILES_CACHE_DIR/homebrew_prefix" ]; then
    HOMEBREW_PREFIX="$(cat "$DOTFILES_CACHE_DIR/homebrew_prefix")"
  else
    HOMEBREW_PREFIX="$(brew --prefix)"
    echo "$HOMEBREW_PREFIX" > "$DOTFILES_CACHE_DIR/homebrew_prefix"
  fi
  # See https://docs.brew.sh/Analytics
  export HOMEBREW_NO_ANALYTICS=1
fi


# XDG config location overrides
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export HISTFILE="$XDG_STATE_HOME/$SHELL_NAME/history"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export KODI_DATA="$XDG_DATA_HOME/kodi"

# export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
