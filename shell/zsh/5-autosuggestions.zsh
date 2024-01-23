AUTOSUGGESTIONS_FILE="$DOTFILES_DIR/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh"

if [ -f "$AUTOSUGGESTIONS_FILE" ]; then
  export ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd history)
  export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
  source "$AUTOSUGGESTIONS_FILE"
fi
unset AUTOSUGGESTIONS_FILE
