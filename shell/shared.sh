# shellcheck shell=bash
#
# Shared setup, always happens first and the only time that
# OS is setup second.
#
safe_source "$DOTFILES_DIR/shell/std/shared.sh"
safe_source "$DOTFILES_DIR/shell/${OS_NAME}/shared.sh"
