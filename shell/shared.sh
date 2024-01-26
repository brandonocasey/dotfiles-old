# ~~ Functions ~~
cmd_exists() {
  if command -v "$1" >/dev/null 2>&1; then
    return 0
  fi

  return 1
}

path_add() {
  # remove trailing slashes
  local dir="${1%%+(/)}"

  case ":${PATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) PATH="$PATH:$dir"  ;;
  esac
}

manpath_add() {
  # remove trailing slashes
  local dir="${1%%+(/)}"

  case ":${MANPATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) MANPATH="$MANPATH:$dir"  ;;
  esac
}

infopath_add() {
  # remove trailing slashes
  local dir="${1%%+(/)}"

  case ":${INFOPATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) INFOPATH="$INFOPATH:$dir"  ;;
  esac
}

fpath_add() {
  # remove trailing slashes
  local dir="${1%%+(/)}"

  case ":${FPATH:=$dir}:" in
    *:"$dir":*)  ;;
    *) FPATH="$FPATH:$dir"  ;;
  esac
}

safe_source() {
  [ -f "$1" ] && source "$1"
}

# ~~ PATH ~~
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
  export HOMEBREW_PREFIX="$(brew --prefix)"
  # See https://docs.brew.sh/Analytics
  export HOMEBREW_NO_ANALYTICS=1
  path_add "$HOMEBREW_PREFIX/bin"
  path_add "$HOMEBREW_PREFIX/sbin"
  manpath_add "$HOMEBREW_PREFIX/share/man"
  infopath_add "$HOMEBREW_PREFIX/share/info"
  fpath_add "$HOMEBREW_PREFIX/share/zsh/site-functions/"
fi

if cmd_exists docker; then
  path_add "$DOTFILES_DIR/docker-bin"
fi

path_add "$DOTFILES_DIR/bin"
manpath_add "$DOTFILES_DIR/man"
infopath_add "$DOTFILES_DIR/info"
fpath_add "$DOTFILES_DIR/shell/zsh-functions"
path_add "$HOME/.local/bin"
manpath_add "$HOME/.local/man"
infopath_add "$HOME/.local/info"
fpath_add "$HOME/.local/zsh-functions"
