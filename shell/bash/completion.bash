bash_completion="/etc/bash_completion"

if [ -n "$HOMBREW_PREFIX" ]; then
  bash_completion="$HOMBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

if [ -f "$bash_completion" ]; then
  echo ". $bash_completion"
fi

unset bash_completion
