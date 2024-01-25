# Change shell to zsh if needed
best_zsh="$(which zsh)"
if [ "$SHELL" != "$best_zsh" ] && cmd_exists zsh; then
  if ! grep -q "$best_zsh" /etc/shells; then
    echo "$best_zsh" | sudo tee -a /etc/shells
  fi
  run_dotfile_cmd chsh -s "$best_zsh"
fi

unset best_zsh
