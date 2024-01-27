# shellcheck shell=bash
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
