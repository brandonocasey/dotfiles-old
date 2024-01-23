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

# XDG config location overrides
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export HISTFILE="$XDG_STATE_HOME/$SHELL_NAME/history"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"

# export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export RIPGREP_CONFIG_PATH="$XDG_DATA_HOME/ripgrep/config"

# Don't warn me about mail
unset MAILCHECK

# finding things
export GREP_OPTIONS="--color=auto"

# 1 Billion lines of history
export HISTSIZE=10000000
export HISTFILESIZE=$HISTSIZE
