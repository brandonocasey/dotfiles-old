# shellcheck shell=bash
cmd_exists() {
  if command -v "$1" >/dev/null 2>&1; then
    return 0
  fi

  return 1
}

path_add() {
  # remove trailing slashes
  local dir="${1%%+(/)}"

  case ":${PATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) PATH="$PATH:$dir"  ;;
  esac
}

manpath_add() {
  # remove trailing slashes
  local dir="${1%%+(/)}"

  case ":${MANPATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) MANPATH="$MANPATH:$dir"  ;;
  esac
}

infopath_add() {
  # remove trailing slashes
  local dir="${1%%+(/)}"

  case ":${INFOPATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) INFOPATH="$INFOPATH:$dir"  ;;
  esac
}

fpath_add() {
  # remove trailing slashes
  local dir="${1%%+(/)}"

  case ":${FPATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) FPATH="$FPATH:$dir"  ;;
  esac
}
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
export CARGO_HOME="$XDG_DATA_HOME/cargo"

export DOTFILES_DIR="$XDG_CONFIG_HOME/dotfiles"
export DOTFILES_BUILD_DIR="$XDG_DATA_HOME/dotfiles"
export DOTFILES_CACHE_DIR="$XDG_DATA_HOME/dotfiles"

mkdir -p "$DOTFILES_CACHE_DIR"
# shellcheck shell=bash
# PATH Priority is
# $HOME -> $DOTFILES_DIR -> (Homebrew if exists) -> global
path_add "/usr/local/bin"
path_add "/usr/bin"
path_add "/bin"
path_add "/usr/sbin"
path_add "/sbin"
#path_add "./vendor/bin"
#path_add "./bin"
#path_add "./node_modules/.bin"
#path_add "../node_modules/.bin"
#path_add "../../node_modules/.bin"
#path_add "../../../node_modules/.bin"
path_add "/usr/local/sbin"
manpath_add "/usr/share/man"
manpath_add "/usr/local/share/man"
path_add "$XDG_DATA_HOME/npm/bin"
path_add "$CARGO_HOME/bin"

if cmd_exists brew; then
  if [ -f "$DOTFILES_CACHE_DIR/homebrew_prefix" ]; then
    HOMEBREW_PREFIX="$(cat "$DOTFILES_CACHE_DIR/homebrew_prefix")"
  else
    HOMEBREW_PREFIX="$(brew --prefix)"
    echo "$HOMEBREW_PREFIX" > "$DOTFILES_CACHE_DIR/homebrew_prefix"
  fi
  export HOMEBREW_PREFIX
  # See https://docs.brew.sh/Analytics
  export HOMEBREW_NO_ANALYTICS=1

  path_add "$HOMEBREW_PREFIX/bin"
  path_add "$HOMEBREW_PREFIX/sbin"
  manpath_add "$HOMEBREW_PREFIX/share/man"
  infopath_add "$HOMEBREW_PREFIX/share/info"
  fpath_add "$HOMEBREW_PREFIX/share/zsh/site-functions/"
  if cmd_exists fzf; then
    export FZF_DIR="$HOMEBREW_PREFIX/opt/fzf)"
  fi
  if cmd_exists asdf; then
    export ASDF_DIR="$HOMEBREW_PREFIX/opt/asdf"
  fi
fi

path_add "$DOTFILES_DIR/bin"
manpath_add "$DOTFILES_DIR/man"
infopath_add "$DOTFILES_DIR/info"
fpath_add "$DOTFILES_DIR/zsh-functions"
path_add "$HOME/.local/bin"
manpath_add "$HOME/.local/share/man"
infopath_add "$HOME/.local/share/info"
fpath_add "$HOME/.local/zsh/site-functions"
# shellcheck shell=sh

if [ -n "$ASDF_DIR" ] && [ -d "$ASDF_DIR" ]; then
  export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
  export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
  export ASDF_DIRENV_IGNORE_MISSING_PLUGINS=1
  export DIRENV_LOG_FORMAT=""
  export ASDF_DIRENV_NO_TOUCH_RC_FILE=1

  mkdir -p "$ASDF_DATA_DIR"
  mkdir -p "$(dirname "$ASDF_CONFIG_FILE")"

  if [ "$SHELL_NAME" = 'zsh' ]; then
    # append completions to fpath
    fpath_add "${ASDF_DIR}/completions"
  elif [ "$SHELL_NAME" = "bash" ]; then
    safe_source "$ASDF_DIR/completions/asdf.bash"
  fi

  safe_source "${XDG_CONFIG_HOME}/asdf-direnv/${SHELL_NAME}rc"
fi
# shellcheck shell=sh

# FZF_DIR comes from os installation
if [ -n "$SHELL_NAME" ] && [ -n "$FZF_DIR" ] && [ -d "$FZF_DIR" ]; then
  # manpath_add "$FZF_DIR/man"
  # path_add "$FZF_DIR/bin"
  safe_source "$FZF_DIR/shell/completion.$SHELL_NAME"
  safe_source "$FZF_DIR/shell/key-bindings.$SHELL_NAME"
  if cmd_exists fd; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
fi

unset FZF_DIR
# shellcheck shell=sh

if [ "$OS_NAME" = 'mac' ]; then
  if [ -f "/Applications/VSCodium.app/" ]; then
    path_add "/Applications/VSCodium.app/Contents/Resources/app/bin/codium"
  fi
fi
# shellcheck shell=sh

if [ "$TERM_PROGRAM" = "WezTerm" ] && [ -n "$WEZTERM_FILE" ] && [ -f "$WEZTERM_FILE" ]; then
  safe_source "$WEZTERM_FILE"
fi

unset WEZTERM_FILE

export HOMEBREW_BUNDLE_FILE_GLOBAL="$DOTFILES_DIR/configs/mac/Brewfile"

echo "$PATH"
