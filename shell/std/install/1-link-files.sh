# shellcheck shell=bash

# remove files so that our links will work
rm_files=(
  "$HOME/.gitconfig"
  "$HOME/.gitignore"
  "$HOME/.tmux.conf"
  "$HOME/.npmrc"
  "$HOME/.inputrc"
)

declare -A link_files
link_files=(
  ["$XDG_CONFIG_HOME/ripgrep/config"]="configs/ripgrep"
  ["$XDG_CONFIG_HOME/wezterm/wezterm.lua"]="configs/wezterm.lua"
  ["$XDG_CONFIG_HOME/git/config"]="configs/gitconfig"
  ["$XDG_CONFIG_HOME/git/ignore"]="configs/gitignore"
  ["$XDG_CONFIG_HOME/tmux/tmux.conf"]="configs/tmux.conf"
  ["$XDG_CONFIG_HOME/python/pythonrc"]="configs/pythonrc"
  ["$XDG_CONFIG_HOME/readline/inputrc"]="configs/inputrc"
  ["$XDG_CONFIG_HOME/npm/npmrc"]="configs/npmrc"
  ["$XDG_CONFIG_HOME/nvim/lua/custom"]="configs/nvim/nvchad"
  ["$XDG_CONFIG_HOME/direnv/direnv.toml"]="configs/direnv.toml"
  ["$XDG_CONFIG_HOME/sheldon/plugins.toml"]="configs/sheldon.toml"
  ["$HOME/.tool-versions"]="configs/tool-versions"
  ["$HOME/.telnetrc"]="configs/telnetrc"
  ["$HOME/.envrc"]="configs/envrc"
  ["$HOME/.zshrc"]="shell/index.sh"
  ["$HOME/.bashrc"]="shell/index.sh"
)
  # ["$XDG_CONFIG_HOME/vim/vimrc"]="configs/vim/vimrc"

if [ "$OS_NAME" = 'mac' ]; then
  link_files+=(
    ["$XDG_CONFIG_HOME/karabiner"]="configs/mac/karabiner"
    ["$XDG_CONFIG_HOME/iterm2"]="configs/mac/iterm2"
    ["$XDG_CONFIG_HOME/hammerspoon"]="configs/mac/hammerspoon"
    ["$HOME/.vscode-oss/extensions/extensions.json"]="configs/vscodium-extensions.json"
    ["$HOME/Library/Application Support/VSCodium/User/settings.json"]="configs/vscodium-settings.json"
    ["$HOME/Library/Application Support/com.nuebling.mac-mouse-fix/config.plist"]="configs/mac/mac-mouse-fix.plist"
    ["$HOME/Library/Application Support/Rectangle/RectangleConfig.json"]="configs/mac/RectangleConfig.json"
  )
fi


keys=()

keys_for_array link_files keys

for link_file in "${keys[@]}"; do
  target="$DOTFILES_DIR/${link_files[$link_file]}"

  run_dotfile_cmd mkdir -p "$(dirname $link_file)"
  run_dotfile_cmd ln -snf "$target" $link_file
done

for file in "${rm_files[@]}"; do
  if [ -f "$file" ]; then
    run_dotfile_cmd rm -f "$file"
  fi
done

unset link_files
unset target
unset file
unset target
unset keys
