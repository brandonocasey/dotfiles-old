# TODO: This needs to go after plugins i think
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zcompile -R -- "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION".zwc "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
