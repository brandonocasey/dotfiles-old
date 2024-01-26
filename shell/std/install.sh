# shellcheck shell=bash
mkdir -p "$DOTFILES_BUILD_DIR"
export DOTFILES_INSTALL_LOG="$DOTFILES_BUILD_DIR/install.log"

: > "$DOTFILES_LOG"

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

run_dotfile_cmd() {
  echo "  $*" >> "$DOTFILES_LOG"
  "$@"
}

run_dotfile_cmd_async() {
  run_dotfile_cmd "$@" &
  disown
}

for file in "$DOTFILES_DIR"/shell/install/*; do
  echo "~~ $(basename "$file") ~~" >> "$DOTFILES_LOG"
  safe_source "$file"
done

unset file
unset -f keys_for_array
unset DOTFILES_LOG
unset -f run_dotfile_cmd
