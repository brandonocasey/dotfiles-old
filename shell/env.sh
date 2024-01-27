# shellcheck shell=bash
#
# Environment Setup, happens after shared and sometimes after
# install.

safe_source "$DOTFILES_DIR/shell/$OS_NAME/env.sh"
safe_source "$DOTFILES_DIR/shell/std/env.sh"
