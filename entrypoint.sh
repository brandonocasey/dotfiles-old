# shellcheck shell=bash
# ~~ Functions ~~
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

safe_source() {
  [ -f "$1" ] && source "$1"
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

export DOTFILES_DIR="$XDG_CONFIG_HOME/dotfiles"
export DOTFILES_BUILD_DIR="$XDG_DATA_HOME/dotfiles"

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
path_add "$XDG_DATA_HOME/npm/bin"

if cmd_exists brew; then
  export HOMEBREW_PREFIX="$(brew --prefix)"
  # See https://docs.brew.sh/Analytics
  export HOMEBREW_NO_ANALYTICS=1
  path_add "$HOMEBREW_PREFIX/bin"
  path_add "$HOMEBREW_PREFIX/sbin"
  manpath_add "$HOMEBREW_PREFIX/share/man"
  infopath_add "$HOMEBREW_PREFIX/share/info"
  fpath_add "$HOMEBREW_PREFIX/share/zsh/site-functions/"
fi

if cmd_exists docker; then
  path_add "$DOTFILES_DIR/docker-bin"
fi

path_add "$DOTFILES_DIR/bin"
manpath_add "$DOTFILES_DIR/man"
infopath_add "$DOTFILES_DIR/info"
fpath_add "$DOTFILES_DIR/shell/zsh-functions"
path_add "$HOME/bin"
manpath_add "$HOME/man"
infopath_add "$HOME/info"
fpath_add "$HOME/zsh-functions"

declare -A DOTFILES_PLUGINS
DOTFILES_PLUGINS+=(
  ["wezterm"]="https://cdn.githubraw.com/wez/wezterm/29d8bcc6eaae5b5d70d9d4339ca24f68a00eb7a9/assets/shell-integration/wezterm.sh"
  ["zsh-autocomplete"]="https://cdn.githubraw.com/marlonrichert/zsh-autocomplete/c7b65508fd3a016dc9cdb410af9ee7806b3f9be1/zsh-autocomplete.plugin.zsh"
  ["F-Sy-H"]="https://cdn.githubraw.com/z-shell/F-Sy-H/3dea11a9018061e6e3a77e529b79e5654679d3a0/F-Sy-H.plugin.zsh"
  ["powerlevel10k"]="https://cdn.githubraw.com/romkatv/powerlevel10k/bd0fa8a0/powerlevel10k.zsh-theme"
)

# TODO only do if the install directory is missing
#safe_source "$DOTFILES_DIR/os/${OS_NAME}/entrypoint.sh"
#safe_source "$DOTFILES_DIR/shell/install.sh"
#safe_source "$DOTFILES_DIR/shell/env.sh"

unset DOTFILES_PLUGINS
