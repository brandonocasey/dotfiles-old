sheldon lock --update

eval "$(sheldon source)"
# asdf installs
run_dotfile_cmd_async asdf plugin add nodejs
run_dotfile_cmd_async asdf plugin add python
run_dotfile_cmd_async asdf plugin add direnv
run_dotfile_cmd_async asdf install nodejs
run_dotfile_cmd_async asdf install python
run_dotfile_cmd_async asdf direnv setup --version latest


if [ "$SHELL_NAME" = "zsh" ]; then
  old_IFS="$IFS"
  while IFS= read -r -d '' file; do
    run_dotfile_cmd_async zcompile "$file"
  done < <(find "$XDG_DATA_HOME/sheldon" \( -name "*.zsh" -or -name '*.zsh-theme' -or -name '*.sh' \) -print0)

  IFS="$old_IFS"
  unset old_IFS
  unset file
fi

run_dotfile_cmd_async "$DOTFILES_DIR/submodules/fzf/install" --bin
