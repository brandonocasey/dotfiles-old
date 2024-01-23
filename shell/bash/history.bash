# I Want my history to last forever and sync weather or not I log out
# http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
export HISTCONTROL=ignorespace:erasedups
export HISTTIMEFORMAT="%m/%d/%y %T " # Save history timestamps

shopt -s histappend

_bash_history_sync() {
  builtin history -a         #1 appends command to histfile
}
history() {                  #5 overrides build in history to sync it before display
  _bash_history_sync
  builtin history "$@"
}

if echo "$PROMPT_COMMAND" | grep -q "_bash_history_sync"; then
  export PROMPT_COMMAND="_bash_history_sync $PROMPT_COMMAND"
fi

# always append on exit
trap _bash_history_sync EXIT
