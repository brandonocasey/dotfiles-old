# shellcheck shell=zsh
dirs=()
dirs+=("$HOME/Projects")
dirs+=("$XDG_STATE_HOME/bash")
dirs+=("$XDG_CONFIG_HOME/npm")
dirs+=("$XDG_CONFIG_HOME/pg")
dirs+=("$XDG_STATE_HOME/zsh")
dirs+=("$XDG_CACHE_HOME/zsh")
dirs+=("$XDG_CACHE_HOME/less")

for dir in "${dirs[@]}"; do
  run_dotfile_cmd mkdir -p "$dir"
done

unset dirs
unset dir
