# man zshoptions

# -- Completion --
# Allow tab completion with aliases
setopt COMPLETE_ALIASES

# allow comments in interactive commands
setopt INTERACTIVE_COMMENTS

# complete inwords too
setopt COMPLETE_IN_WORD

# dont' automatically cycle through completions
unsetopt MENU_COMPLETE

# -- History --
# remove older commands from the history list that are duplicates of the current one
setopt HIST_IGNORE_ALL_DUPS

# ignore any command that starts with a space
setopt HIST_IGNORE_SPACE

# save every command to history before execution (inc_append_history) and
# read the history file every time history is called upon
setopt INC_APPEND_HISTORY

# -- Input/Output --
unsetopt MAIL_WARN

# -- ZLE --
unsetopt BEEP
