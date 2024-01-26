# Activate Powerlevel10k Instant Prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -f "$DOTFILES_DIR/submodules/p10k/powerlevel10k.zsh-theme" ]; then
  source "$DOTFILES_DIR/submodules/p10k/powerlevel10k.zsh-theme"
fi
