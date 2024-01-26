# shellcheck shell=bash

if [ -n "$ZSH_VERSION" ] && [ -f "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
  safe_source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

STD_DIR="$DOTFILES_DIR/shell/std"
STD_FILES=(
  "$STD_DIR"/sh/*
)

# ~~ main ~~
if [ -n "$SHELL_NAME" ] && [ -d "$STD_DIR/$SHELL_NAME" ]; then
  STD_FILES+=("$STD_DIR/$SHELL_NAME"/*)
fi

STD_FILES+=("$STD_DIR"/plugins/*)

unset STD_DIR

for STD_FILE in "${STD_FILES[@]}"; do
  safe_source "$STD_FILE"
done

unset STD_FILE
unset STD_FILES
