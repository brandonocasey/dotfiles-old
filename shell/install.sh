# shellcheck shell=bash
mkdir -p "$DOTFILES_BUILD_DIR"
export DOTFILES_INSTALL_LOG="$DOTFILES_BUILD_DIR/install.log"

: > "$DOTFILES_INSTALL_LOG"

# https://stackoverflow.com/a/51446108
if [[ $ZSH_VERSION ]]; then
  keys_for_array() {
    local array=$1 dest=$2
    [[ $1 && $2 ]] || { echo "Usage: keys_for_array source-array dest-array" >&2; return 1; }
    : ${(AP)dest::=${(kP)array}}
  }
elif [[ $BASH_VERSION && ! $BASH_VERSION =~ ^([123][.]|4[.][012]) ]]; then
  keys_for_array() {
    [[ $1 && $2 ]] || { echo "Usage: keys_for_array source-array dest-array" >&2; return 1; }
    local -n array=$1 dest=$2
    eval 'dest=( "${!array[@]}" )'
  }
else
  echo "Unsupported Shell"
fi

dotfiles_log() {
  local line
  for line in "$@"; do
    echo "$line" >> "$DOTFILES_INSTALL_LOG"
  done
}

run_dotfile_cmd() {
  echo "  $*" >> "$DOTFILES_INSTALL_LOG"
  "$@"
}

run_dotfile_cmd_async() {
  run_dotfile_cmd "$@" &
  disown
}

unset file
unset -f keys_for_array
unset DOTFILES_LOG
unset -f run_dotfile_cmd
unset -f run_dotfile_cmd_async
