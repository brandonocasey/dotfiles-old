# shellcheck shell=bash
for file in "$DOTFILES_DIR"/shell/std/shared/*; do
  safe_source "$file"
done

unset file
