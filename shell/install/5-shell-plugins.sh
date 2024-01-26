# Download plugins

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
  old_IFS="$IFS"
  while IFS= read -r -d '' file; do
    run_dotfile_cmd_async zcompile "$file"
  done < <(find "$DOTFILES_BUILD_DIR/plugins" \( -name "*.zsh" -or  '*.zsh-theme' -or -name '*.sh' \) -print0)

  IFS="$old_IFS"
  unset old_IFS
  unset file
fi
