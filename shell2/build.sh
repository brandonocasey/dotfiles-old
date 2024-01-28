# shellcheck shell=bash
mkdir -p "$DOTFILES_BUILD_DIR"
export DOTFILES_INSTALL_LOG="$DOTFILES_BUILD_DIR/install.log"

: > "$DOTFILES_INSTALL_LOG"

# https://stackoverflow.com/a/51446108
if [[ $ZSH_VERSION ]]; then
  keys_for_array() {
    local array=$1 dest=$2
    [[ $1 && $2 ]] || { echo "Usage: keys_for_array source-array dest-array" >&2; return 1; }
    : ${(AP)dest::=${(kP)array}}
  }
elif [[ $BASH_VERSION && ! $BASH_VERSION =~ ^([123][.]|4[.][012]) ]]; then
  keys_for_array() {
    [[ $1 && $2 ]] || { echo "Usage: keys_for_array source-array dest-array" >&2; return 1; }
    local -n array=$1 dest=$2
    eval 'dest=( "${!array[@]}" )'
  }
else
  echo "Unsupported Shell"
fi

dotfiles_log() {
  local line
  for line in "$@"; do
    echo "$line" >> "$DOTFILES_INSTALL_LOG"
  done
}

run_dotfile_cmd() {
  echo "  $*" >> "$DOTFILES_INSTALL_LOG"
  "$@"
}

run_dotfile_cmd_async() {
  run_dotfile_cmd "$@" &
  disown
}

unset file
unset -f keys_for_array
unset DOTFILES_LOG
unset -f run_dotfile_cmd
unset -f run_dotfile_cmd_async
#echo "Getting sudo permissions"
#\sudo -v

if [ "$OS_NAME" = "mac" ]; then
  run_dotfile_cmd xcode-select --install
  run_dotfile_cmd sudo xcodebuild -license accept

  if ! cmd_exists brew; then
    run_dotfile_cmd /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  run_dotfile_cmd brew bundle --global

  # set asdf/fzf after install

  # Set dock size
  defaults write com.apple.dock tilesize -int 75

  # Disable press and hold
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  # Always show hidden files
  defaults write com.apple.finder AppleShowAllFiles YES

  # Show Path bar and status bar in finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true

  # opening and closing windows and popovers
  defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

  # smooth scrolling
  defaults write -g NSScrollAnimationEnabled -bool false

  # showing and hiding sheets, resizing preference windows, zooming windows
  # float 0 doesn't work
  defaults write -g NSWindowResizeTime -float 0.001

  # opening and closing Quick Look windows
  defaults write -g QLPanelAnimationDuration -float 0

  # rubberband scrolling (doesn't affect web views)
  defaults write -g NSScrollViewRubberbanding -bool false

  # resizing windows before and after showing the version browser
  # also disabled by NSWindowResizeTime -float 0.001
  defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false

  # showing a toolbar or menu bar in full screen
  defaults write -g NSToolbarFullScreenAnimationDuration -float 0

  # scrolling column views
  defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0

  # showing the Dock
  defaults write com.apple.dock autohide-time-modifier -float 0
  defaults write com.apple.dock autohide-delay -float 0

  # showing and hiding Mission Control, command+numbers
  defaults write com.apple.dock expose-animation-duration -float 0

  # showing and hiding Launchpad
  defaults write com.apple.dock springboard-show-duration -float 0
  defaults write com.apple.dock springboard-hide-duration -float 0

  # changing pages in Launchpad
  defaults write com.apple.dock springboard-page-duration -float 0

  # at least AnimateInfoPanes
  defaults write com.apple.finder DisableAllAnimations -bool true

  # sending messages and opening windows for replies
  defaults write com.apple.Mail DisableSendAnimations -bool true
  defaults write com.apple.Mail DisableReplyAnimations -bool true

  # disable dock bouncing
  defaults write com.apple.dock no-bouncing -bool TRUE

  # Faster key repeat
  defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)<Paste>

  # disable mouse acceleration
  defaults write .GlobalPreferences com.apple.mouse.scaling -1
  defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1

  # autohide dock
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.dock autohide-time-modifier -float 0

  # prevent dsstore
  defaults write com.apple.desktopservices DSDontWriteNetworkStores true
  defaults write com.apple.desktopservices DSDontWriteUSBStores true

  # always show scroll bars
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

  # Menu bar: show remaining battery percentage; hide time
  defaults write com.apple.menuextra.battery ShowPercent -string "YES"
  defaults write com.apple.menuextra.battery ShowTime -string "NO"
  # Menu bar: show remaining battery percentage (with Big Sur or Monterey)
  defaults write com.apple.controlcenter.plist BatteryShowPercentage -bool true

  # Disable the "Are you sure you want to open this application?" dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Expand save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode  -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  # Disable automatic capitalization as it’s annoying when typing code
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes as they’re annoying when typing code
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes as they’re annoying when typing code
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Bottom right screen corner -> Start screen saver
  defaults write com.apple.dock wvous-br-corner -int 5

  # Do not keep recently used apps
  defaults write com.apple.dock show-recents -bool false

  # Enable Safari’s debug menu
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

  # Visualize CPU usage in the Activity Monitor Dock icon
  defaults write com.apple.ActivityMonitor IconType -int 5

  # Show all processes in Activity Monitor
  defaults write com.apple.ActivityMonitor ShowCategory -int 0

  # Sort Activity Monitor results by CPU usage
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0

  # Specify the preferences directory
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$XDG_CONFIG_HOME/.iterm2"

  # Tell iTerm2 to use the custom preferences in the directory
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

  # tell hammerspoon to use this as the config directory
  defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"

  # change to always dark mode
  osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'

  killall Dock
  killall Finder
  killall Rectangle || true
  killall Hammerspoon || true
  killall Karabiner-Elements || true
  open /Applications/Hammerspoon.app/
  open /Applications/Karabiner-Elements.app/
  open /Applications/Rectangle.app/

fi

echo "Settings:"
echo "Now change mouse/trackpad settings"
echo "  a. Mouse"
echo "    i. Point & Click: Secondary Click Only + fastest mouse speed"
echo "    ii. More Gestures: All checked"
echo "    iii. Uncheck Scroll direction: Natural"
echo "  b. Trackpad"
echo "    i. Point & Click: All but look up and data detectors"
echo "mouse double click speed 3 notches below max"
echo "Night shift and 1 min Do not Disturb"
echo "Setup touch id"
echo "Show battery percentage in bar"
echo "Add sound icon to menu bar"
echo "Add Path to finder toolbar"
echo "Add Favorites"
echo "Change computer name via System Preferences -> Sharing -> Computer Name: "
echo "System appearance to dark always"
echo "bottom bar: "
echo "- finder"
echo "- zoom"
echo "- chrome"
echo "- logitech camera"
echo "- system settings"
echo "- spotify"
echo "- speedcrunch"
echo "- devutils"
echo "- activity monitor"
echo "- browserstack local"
echo "- sublime"
echo "- vscodium"
echo "- openvpn"

echo "Install Epson printer utils"
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
# Change shell to zsh if needed
best_zsh="$(which zsh)"
if [ "$SHELL" != "$best_zsh" ] && cmd_exists zsh; then
  if ! grep -q "$best_zsh" /etc/shells; then
    echo "$best_zsh" | sudo tee -a /etc/shells
  fi
  run_dotfile_cmd chsh -s "$best_zsh"
fi

unset best_zsh
# Download plugins

sheldon lock --update

# asdf installs
if [ -n "$ASDF_DIR" ] && [ -d "$ASDF_DIR" ] && cmd_exists asdf; then
  run_dotfile_cmd_async asdf plugin add nodejs
  run_dotfile_cmd_async asdf plugin add python
  run_dotfile_cmd_async asdf plugin add direnv
  run_dotfile_cmd_async asdf install nodejs
  run_dotfile_cmd_async asdf install python
  run_dotfile_cmd_async asdf direnv setup --version latest
fi

if [ "$SHELL_NAME" = "zsh" ]; then
  for file in "$DOTFILES_BUILD_DIR"/plugins/*.{zsh,sh,zsh-theme}; do
    run_dotfile_cmd_async zcompile "$file"
  done
SHELDON_PROFILE="wezterm" sheldon source 1>/dev/null

  unset file
fi
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

if cmd_exists zsh; then
  move_list+=(["$HOME/.zcompdump"]="$XDG_CACHE_HOME/zsh/zcompdump-$(zsh -c 'echo "$ZSH_VERSION"')")
fi

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
