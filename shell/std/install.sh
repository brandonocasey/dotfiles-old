# shellcheck shell=bash

for file in "$DOTFILES_DIR"/shell/std/install/*; do
  dotfiles_log "~~ $(basename "$file") ~~"
  safe_source "$file"
done

unset file
