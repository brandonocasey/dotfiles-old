# shellcheck shell=sh

WEZTERM_FILE="$DOTFILES_DIR/submodules/wezterm/assets/shell-integration/wezterm.sh"
if [ "$TERM_PROGRAM" = "WezTerm" ] && [ -f "$WEZTERM_FILE" ]; then
  source "$WEZTERM_FILE"
fi

unset WEZTERM_FILE
