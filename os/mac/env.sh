if cmd_exists brew; then
  if cmd_exists fzf; then
    export FZF_DIR="$(brew --prefix fzf)"
  fi
  if cmd_exists asdf; then
    export ASDF_DIR="$(brew --prefix asdf)"
fi
