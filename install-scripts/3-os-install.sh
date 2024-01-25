if [ -n "$OS_NAME" ] && [ -f "$DOTFILES_DIR/os/$OS_NAME/install.sh" ]; then
  echo "Installing os specific stuff"
  source "$DOTFILES_DIR/os/$OS_NAME/install.sh"
fi
