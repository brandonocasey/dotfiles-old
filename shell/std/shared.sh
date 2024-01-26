# shellcheck shell=bash
safe_source() {
  [ -f "$1" ] && source "$1"
}

safe_source "$DOTFILES_DIR/shell/std/shared.sh"
safe_source "$DOTFILES_DIR/shell/${OS_NAME}/shared.sh"
