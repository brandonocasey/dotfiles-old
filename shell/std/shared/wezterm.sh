# shellcheck shell=sh

if [ "$TERM_PROGRAM" = "WezTerm" ] && [ -n "$WEZTERM_FILE" ] && [ -f "$WEZTERM_FILE" ]; then
  safe_source "$WEZTERM_FILE"
fi

unset WEZTERM_FILE
