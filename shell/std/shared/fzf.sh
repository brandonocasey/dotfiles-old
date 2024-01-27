# shellcheck shell=sh

# FZF_DIR comes from os installation
if [ -n "$SHELL_NAME" ] && [ -n "$FZF_DIR" ] && [ -f "$FZF_DIR/install" ]; then
  manpath_add "$FZF_DIR/man"
  path_add "$FZF_DIR/bin"
  safe_source "$FZF_DIR/shell/completion.$SHELL_NAME"
  safe_source "$FZF_DIR/shell/key-bindings.$SHELL_NAME"
  if cmd_exists fd; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
fi

unset FZF_DIR
