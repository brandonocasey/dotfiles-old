# shellcheck shell=sh

export ASDF_DIR="$DOTFILES_DIR/submodules/asdf"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
export ASDF_DIRENV_IGNORE_MISSING_PLUGINS=1
export DIRENV_LOG_FORMAT=""
export ASDF_DIRENV_NO_TOUCH_RC_FILE=1

mkdir -p "$ASDF_DATA_DIR"
mkdir -p "$(dirname "$ASDF_CONFIG_FILE")"

source "$ASDF_DIR/asdf.sh"

if [ "$SHELL_NAME" = 'zsh' ]; then
  # append completions to fpath
  fpath_add "${ASDF_DIR}/completions"
elif [ "$SHELL_NAME" = "base" ]; then
  source "$ASDF_DIR/completions/asdf.bash"
fi

[ -f "${XDG_CONFIG_HOME}/asdf-direnv/${SHELL_NAME}rc" ] && source "${XDG_CONFIG_HOME}/asdf-direnv/${SHELL_NAME}rc"
