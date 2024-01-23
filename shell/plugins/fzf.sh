# shellcheck shell=sh

FZF_DIR="$DOTFILES_DIR/submodules/fzf"

if [ -n "$SHELL_NAME" ] && [ -f "$FZF_DIR/install" ]; then
  manpath_add "$FZF_DIR/man"
  path_add "$FZF_DIR/bin"
  source "$FZF_DIR/shell/completion.$SHELL_NAME"
  source "$FZF_DIR/shell/key-bindings.$SHELL_NAME"
fi

unset FZF_DIR
