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
