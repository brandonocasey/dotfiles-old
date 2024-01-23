# shellcheck shell=sh

if [ "$OS_NAME" = 'mac' ]; then
  if [ -f "/Applications/VSCodium.app/" ]; then
    path_add "/Applications/VSCodium.app/Contents/Resources/app/bin/codium"
  fi
fi
