# shellcheck shell=zsh
declare -A link_files

rm_files=()

# remove files so that our links will work
rm_files+=("$HOME/.gitconfig")
rm_files+=("$HOME/.gitignore")
rm_files+=("$HOME/.tmux.conf")
rm_files+=("$HOME/.npmrc")
rm_files+=("$HOME/.inputrc")

link_files+=(["$XDG_CONFIG_HOME/dotfiles"]=".")
link_files+=(["$XDG_CONFIG_HOME/ripgrep/config"]="configs/ripgrep")
link_files+=(["$XDG_CONFIG_HOME/wezterm/wezterm.lua"]="configs/wezterm.lua")
link_files+=(["$XDG_CONFIG_HOME/git/config"]="configs/gitconfig")
link_files+=(["$XDG_CONFIG_HOME/git/ignore"]="configs/gitignore")
link_files+=(["$XDG_CONFIG_HOME/tmux/tmux.conf"]="configs/tmux.conf")
link_files+=(["$XDG_CONFIG_HOME/python/pythonrc"]="configs/pythonrc")
link_files+=(["$XDG_CONFIG_HOME/readline/inputrc"]="configs/inputrc")
link_files+=(["$XDG_CONFIG_HOME/npm/npmrc"]="configs/npmrc")
link_files+=(["$XDG_CONFIG_HOME/nvim/lua/custom"]="configs/nvim/nvchad")
# link_files+=(["$XDG_CONFIG_HOME/vim/vimrc"]="configs/vim/vimrc")
link_files+=(["$XDG_CONFIG_HOME/direnv/direnv.toml"]="configs/direnv.toml")
link_files+=(["$HOME/.tool-versions"]="configs/tool-versions")
link_files+=(["$HOME/.telnetrc"]="configs/telnetrc")
link_files+=(["$HOME/.envrc"]="configs/envrc")
link_files+=(["$HOME/.zshrc"]="shell/index.sh")
link_files+=(["$HOME/.bashrc"]="shell/index.sh")

if [ "$OS_NAME" = 'mac' ]; then
  link_files+=(["$XDG_CONFIG_HOME/karabiner"]="os/mac/configs/karabiner")
  link_files+=(["$XDG_CONFIG_HOME/iterm2"]="os/mac/configs/iterm2")
  link_files+=(["$XDG_CONFIG_HOME/hammerspoon"]="os/mac/configs/hammerspoon")
  link_files+=(["$HOME/.vscode-oss/extensions/extensions.json"]="configs/vscodium-extensions.json")
  link_files+=(["$HOME/Library/Application Support/VSCodium/User/settings.json"]="configs/vscodium-settings.json")
  link_files+=(["$HOME/Library/Application Support/com.nuebling.mac-mouse-fix/config.plist"]="os/mac/configs/mac-mouse-fix.plist")
  link_files+=(["$HOME/Library/Application Support/Rectangle/RectangleConfig.json"]="os/mac/configs/RectangleConfig.json")
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
