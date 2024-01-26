if cmd_exists brew; then
  if cmd_exists fzf; then
    export FZF_DIR="$HOMEBREW_PREFIX/opt/fzf)"
  fi
  if cmd_exists asdf; then
    export ASDF_DIR="$HOMEBREW_PREFIX/opt/asdf"
  fi
fi

export HOMEBREW_BUNDLE_FILE_GLOBAL="$DOTFILES_DIR/configs/mac/Brewfile"
