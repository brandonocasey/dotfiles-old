declare -A move_list

move_list+=(["$HOME/.android"]="$XDG_DATA_HOME/android")
move_list+=(["$HOME/.asdf"]="$XDG_CONFIG_HOME/asdf")
move_list+=(["$HOME/.docker"]="$XDG_CONFIG_HOME/docker")
move_list+=(["$HOME/.gnupg"]="$XDG_DATA_HOME/gnupg")
move_list+=(["$HOME/.zcompcache"]="$XDG_CACHE_HOME/zsh/zcompcache")


move_list+=(["$HOME/.bash_history"]="$XDG_STATE_HOME/bash/history")
move_list+=(["$HOME/.lesshst"]="$XDG_CACHE_HOME/less/history")
move_list+=(["$HOME/.node_repl_history"]="$XDG_DATA_HOME/node_repl_history")
move_list+=(["$HOME/.pgpass"]="$XDG_CONFIG_HOME/pg/pgpass")
move_list+=(["$HOME/.python_history"]="$XDG_CACHE_HOME/python_history")
move_list+=(["$HOME/.wget-hsts"]="$XDG_DATA_HOME/wget-hsts")
move_list+=(["$HOME/.zsh_history"]="$XDG_STATE_HOME/zsh/history")

# TODO: fix for bash move_files+=(["$HOME/.zcompdump"]="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION")
keys=()
keys_for_array move_list keys

__move() {
  local src="$1"
  local dest="$2"

  # src does not exist do nothing
  if ! [ -f "$src" ] || ! [ -d "$src" ]; then
    run_dotfile_cmd echo "$src does not exist cannot move to $dest"
    return
  fi

  # dest alerady exists do nothing
  if [ -f "$dest" ] || [ -d "$dest" ]; then
    run_dotfile_cmd echo "$dest already exists cannot move $src to it"
    return
  fi

  local parent="$(dirname "$dest")"

  [ -d "$parent" ] || run_dotfile_cmd mkdir -p "$parent"
  run_dotfile_cmd mv "$src" "$dest"
}

for src in "${keys[@]}"; do
  __move "$src" "${move_list[$src]}"
done

if [ -d "$HOME/.npm" ]; then
  run_dotfile_cmd_async rm -rf "$HOME/.npm"
fi

if [ -d "$HOME/.bundle" ]; then
  run_dotfile_cmd_async rm -rf "$HOME/.bundle"
fi

unset -f __move
unset src
unset keys
unset move_list
