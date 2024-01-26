# shellcheck shell=bash

# zmodload zsh/zprof
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

declare -A DOTFILES_PLUGINS
DOTFILES_PLUGINS+=(
  ["wezterm"]="https://cdn.githubraw.com/wez/wezterm/29d8bcc6eaae5b5d70d9d4339ca24f68a00eb7a9/assets/shell-integration/wezterm.sh"
  ["zsh-autocomplete"]="https://cdn.githubraw.com/marlonrichert/zsh-autocomplete/c7b65508fd3a016dc9cdb410af9ee7806b3f9be1/zsh-autocomplete.plugin.zsh"
  ["F-Sy-H"]="https://cdn.githubraw.com/z-shell/F-Sy-H/3dea11a9018061e6e3a77e529b79e5654679d3a0/F-Sy-H.plugin.zsh"
  ["powerlevel10k"]="https://cdn.githubraw.com/romkatv/powerlevel10k/bd0fa8a0/powerlevel10k.zsh-theme"
)

source "$DOTFILES_DIR/shell/shared.sh"
# TODO only do if the install directory is missing
safe_source "$DOTFILES_DIR/shell/install.sh"
safe_source "$DOTFILES_DIR/shell/env.sh"

unset DOTFILES_PLUGINS
#zprof
