# shellcheck shell=sh

editor='nano';

# Set default command editor to vim
if cmd_exists nvim; then
  export MANPAGER="nvim +Man!"
  editor='nvim'
elif cmd_exists vim; then
  editor='vim'
elif bin_exist vi; then
  editor='vi'
fi

export FCEDIT=$editor
export EDITOR=$editor
export VISUAL=$editor
export VISUAL_EDITOR=$editor
export SVN_EDITOR=$editor
export GIT_EDITOR=$editor

unset editor

# themed ls colors
if cmd_exists vivid; then
  export LS_COLORS="$(vivid generate one-dark)"
else
  export LSCOLORS=GxFxCxDxBxegedabagaced
fi


# Don't warn me about mail
unset MAILCHECK

# finding things
export GREP_OPTIONS="--color=auto"

# 1 Billion lines of history
export HISTSIZE=10000000
export HISTFILESIZE=$HISTSIZE
