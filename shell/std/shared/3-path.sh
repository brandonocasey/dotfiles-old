# shellcheck shell=bash
# PATH Priority is
# $HOME -> $DOTFILES_DIR -> (Homebrew if exists) -> global
path_add "/usr/local/bin"
path_add "/usr/bin"
path_add "/bin"
path_add "/usr/sbin"
path_add "/sbin"
path_add "./vendor/bin"
path_add "./bin"
path_add "./node_modules/.bin"
path_add "../node_modules/.bin"
path_add "../../node_modules/.bin"
path_add "../../../node_modules/.bin"
path_add "$HOME/.cargo/bin"
path_add "/usr/local/sbin"
manpath_add "/usr/share/man"
manpath_add "/usr/local/share/man"
path_add "$XDG_DATA_HOME/npm/bin"

if cmd_exists brew; then
  path_add "$HOMEBREW_PREFIX/bin"
  path_add "$HOMEBREW_PREFIX/sbin"
  manpath_add "$HOMEBREW_PREFIX/share/man"
  infopath_add "$HOMEBREW_PREFIX/share/info"
  fpath_add "$HOMEBREW_PREFIX/share/zsh/site-functions/"
fi

path_add "$DOTFILES_DIR/bin"
manpath_add "$DOTFILES_DIR/man"
infopath_add "$DOTFILES_DIR/info"
fpath_add "$DOTFILES_DIR/zsh-functions"
path_add "$HOME/.local/bin"
manpath_add "$HOME/.local/share/man"
infopath_add "$HOME/.local/share/info"
fpath_add "$HOME/.local/zsh/site-functions"
