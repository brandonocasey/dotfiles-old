# shellcheck shell=sh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
#zmodload zsh/zprof

safe_source "$DOTFILES_DIR/os/$OS_NAME/env.sh"

if [ -n "$ZSH_VERSION" ] && [ -f "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
  safe_source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ~~ main ~~
if [ -n "$SHELL_NAME" ]; then
  for file in "$DOTFILES_DIR"/shell/sh/* "$DOTFILES_DIR"/shell/"$SHELL_NAME"/* "$DOTFILES_DIR"/shell/plugins/*; do
    safe_source "$file"
  done
else
  for file in "$DOTFILES_DIR"/shell/sh/* "$DOTFILES_DIR"/shell/plugins/*; do
    safe_source "$file"
  done
fi

unset file

#zprof
