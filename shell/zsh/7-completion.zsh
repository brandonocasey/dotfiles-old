zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

ZCOMPDUMP_FILE="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
autoload -Uz compinit

# TODO: add a mechanism for setting refresh time and cache clearing
# https://gist.github.com/ctechols/ca1035271ad134841284
# only compinit and zcompile once a day
if [ "$(find "$ZCOMPDUMP_FILE" -mtime +1)" ] ; then
  zcompile -R -- "${ZCOMPDUMP_FILE}.zwc" "$ZCOMPDUMP_FILE"
  compinit -d "$ZCOMPDUMP_FILE"
  # Have another thread refresh the cache in the background (subshell to hide output)
  (autoload -Uz compinit; compinit d "$ZCOMPDUMP_FILE" &)
else
  compinit -d "$ZCOMPDUMP_FILE" -C
fi

unset ZCOMPDUMP_FILE
