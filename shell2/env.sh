# shellcheck shell=bash
if [ -n "$ZSH_VERSION" ] && [ -f "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
  safe_source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# TODO: cache this in DOTFILES_CACHE_DIR
if tput setaf 1>/dev/null 2>/dev/null; then
  tput sgr0 1>/dev/null 2>/dev/null
  if [[ "$(tput colors)" -ge 256 ]] 2>/dev/null; then
    RED="$(tput setaf 196)"
    ORANGE="$(tput setaf 202)"
    YELLOW="$(tput setaf 226)"
    GREEN="$(tput setaf 34)"
    BLUE="$(tput setaf 21)"
    LIGHT_BLUE="$(tput setaf 51)"
    PURPLE="$(tput setaf 58)"
    PINK="$(tput setaf 171)"
    WHITE="$(tput setaf 255)"
    GRAY="$(tput setaf 244)"
    GREY="$(tput setaf 244)"
    BLACK="$(tput setaf 256)"
    BROWN="$(tput setaf 130)"
    CYAN="$(tput setaf 39)"
  else
    echo "Warning: Your terminal does not have 256 colors support!" 1>&2
    RED="$(tput setaf 1)"
    ORANGE=""
    YELLOW="$(tput setaf 3)"
    GREEN="$(tput setaf 2)"
    BLUE="$(tput setaf 4)"
    LIGHT_BLUE=""
    PURPLE=""
    PINK="$(tput setaf 5)"
    WHITE="$(tput setaf 7)"
    GRAY=""
    GREY=""
    BLACK="$(tput setaf 0)"
    BROWN=""
    CYAN="$(tput setaf 6)"
  fi
  BOLD="$(tput bold)"
  RESET="$(tput sgr0)"
  DIM="$(tput dim)"
else
  echo "Warning: Your terminal does not have 256 colors support!" 1>&2
  RED='\e[0;31m'
  ORANGE='\033[1;33m'
  YELLOW='\e[0;33m'
  GREEN='\033[1;32m'
  BLUE=""
  LIGHT_BLUE=""
  PURPLE='\033[1;35m'
  PINK=""
  WHITE='\033[1;37m'
  GRAY=""
  GREY=""
  BLACK='\e[0;30m'
  BROWN=""
  CYAN='\e[0;36m'

  # Extras
  BOLD=""
  RESET='\033[m'
  DIM=""
fi

export RED="$RED"
export ORANGE="$ORANGE"
export YELLOW="$YELLOW"
export GREEN="$GREEN"
export BLUE="$BLUE"
export LIGHT_BLUE="$LIGHT_BLUE"
export PURPLE="$PURPLE"
export PINK="$PINK"
export WHITE="$WHITE"
export GRAY="$GRAY"
export GREY="$GREY"
export BLACK="$BLACK"
export BROWN="$BROWN"
export CYAN="$CYAN"

# Extras
export BOLD="$BOLD"
export RESET="$RESET"
export DIM="$DIM"
#
# Ask before over-writing a file
alias mv='mv -i'

# Ask before deleting a file, and automatically make it recursive
alias rm='rm -i'

# Ask before over-writing a file and recursively copy by default
alias cp='cp -ir'

# We want free disc space in human readable output, trust me
alias df='df -h'

# Automatically make directories recursively
alias mkdir='mkdir -p'

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias dotbot="$DOTFILES_DIR/submodules/dotbot/bin/dotbot -d '$DOTFILES_DIR' -c '$DOTFILES_DIR/dotbot.json'"
alias bp="cd ~/BrandonProjects/"
alias p="cd ~/Projects/"
alias gs='git status'

# use coreutils ls if it exists
if cmd_exists "eza"; then
  alias ls='eza'
  alias ll="eza -l --git --icons --time-style=long-iso"
  alias la='ll -ah'
  alias la_size='la --total-size'
  alias ll_size='ll --total-size'
  alias la_tree='la --tree'
  alias ll_tree='ll --tree'
  alias ls_tree='eza --tree'
  alias tree='lstree'
else
  if [ "$(uname)" = 'Darwin' ] && ! cmd_exists gls; then
    # Show me all files and info about them
    alias ll='ls -lh --color=auto'

    # Show me all files, including .dotfiles, and all info about them
    alias la='ls -lha --color=auto'

    # Show me colors for regular ls too
    alias ls='ls --color=auto'
  else
    lsbin='ls'

    if cmd_exists gls; then
      lsbin=gls
    fi

    alias ls="$lsbin --color=auto"
    # Show me all files and info about them
    alias ll="ls -lh --color=auto"
    # Show me all files, including .dotfiles, and all info about them
    alias la="ls -lha --color=auto"

    unset lsbin
  fi
fi

if cmd_exists s; then
  alias s='s --provider duckduckgo'
  alias web-search='s --provider duckduckgo'
fi

alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# Vim misspellings nuff' said
alias vim='nvim'
alias cim='nvim'
alias bim='nvim'
alias fim='nvim'
alias gim='nvim'
alias vi='nvim'

alias grep='grep --color="always"'

# easy mysql connection just tack on a -h
alias sql='mysql -umysql -pmysql'

# easy mysql dump just tack on a -h
alias sqld='mysqldump -umysql -pmysql --routines --single-transaction'

# reverse a string
alias reverse="perl -e 'print reverse <>'"

# go to root git directory
alias cdgitroot='cd "$(git rev-parse --show-toplevel)"'

# node module bs
alias npmre="rm -rf ./node_modules && npm i"
alias npmrews="rm -rf packages/**/node_modules && npmre"

# node workspace module bs
alias npmrere="rm -f ./package-lock.json && npmre"
alias npmrerews="rm -rf packages/**/node_modules && npmre"

# keep env when going sudo
alias sudo='sudo --preserve-env'

if cmd_exists rlwrap; then
  alias telnet='rlwrap telnet'
fi

if cmd_exists multitail; then
  alias tail='multitail'
else
  alias tail='tail -f'
fi


cdmkdir() {
  mkdir -p "$@"
  cd "$@" || return 1
}

npminit() {
  cdmkdir "$@"
  npm init --yes
}

nkill() {
  if [ "$#" -lt "1" ]; then
    echo '  Usage:'
    echo '    nkill <process_name> ...'
    echo
    echo '  Example:'
    echo '    nkill httpd ssh-agent'
    echo
    return 1
  fi

  pgrep -fl "$@"
  if [ "$?" = "1" ]; then
    echo 'No processes match'
    return 1
  fi
  echo 'Hit [Enter] to pkill, [Ctrl+C] to abort'
  read -r && sudo pkill -9 -f "$@"
}

m_valgrind() {
  if command -v "valgrind" >/dev/null 2>&1; then
    echo "valgrind is not installed"
  fi

  if [ "$#" -ne "2" ]; then
    echo 'Usage:'
    echo '  m_valgrind log_output binary'
    echo
    echo 'Example:'
    echo '  m_valgrind /tmp/http_valgrind.log httpd'
    echo
    return 1
  fi
  sudo valgrind --leak-check=full --show-reachable=yes --log-file="$1" --trace-redir=yes -v "$2"
}

tcpd() {
  random="$(shuf -i 1-100 -n 1)"
  pcap="./${random}.pcap"
  unset random
  (tcpdump -q -s 0 -i any -w "$pcap" >/dev/null 2>&1 &)


  finish() {
    pkill -f "$pcap"
    echo "$pcap"
    trap - INT
    trap
    unset -f finish
    unset pcap
  }

  trap "echo && finish && return 0" INT
  printf 'Hit [Any Key] to kill tcpdump'
  read -r
  finish
}

editor='nano';

# Set default command editor to vim
if cmd_exists nvim; then
  export MANPAGER="nvim +Man!"
  editor='nvim'
elif cmd_exists vim; then
  editor='vim'
elif cmd_exist vi; then
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

# kill processes by partial name
nkill() {
  if [ "$#" -lt "1" ]; then
    echo '  kill process by name'
    echo '  Usage:'
    echo '    nkill <process_name> ...'
    echo
    echo '  Example:'
    echo '    nkill httpd ssh-agent'
    echo
    return 1
  fi

  pgrep -fl "$@"
  if [ "$?" = "1" ]; then
    echo 'No processes match'
    return 1
  fi
  echo 'Hit [Enter] to pkill, [Ctrl+C] to abort'
  read -r && sudo pkill -9 -f "$@"
}

m_valgrind() {
  if command -v "valgrind" >/dev/null 2>&1; then
    echo "valgrind is not installed"
  fi

  if [ "$#" -ne "2" ]; then
    echo 'Usage:'
    echo '  m_valgrind log_output binary'
    echo
    echo 'Example:'
    echo '  m_valgrind /tmp/http_valgrind.log httpd'
    echo
    return 1
  fi
  sudo valgrind --leak-check=full --show-reachable=yes --log-file="$1" --trace-redir=yes -v "$2"
}

tcpd() {
  random="$(shuf -i 1-100 -n 1)"
  pcap="./${random}.pcap"
  unset random
  (tcpdump -q -s 0 -i any -w "$pcap" >/dev/null 2>&1 &)


  finish() {
    pkill -f "$pcap"
    echo "$pcap"
    trap - INT
    trap
    unset -f finish
    unset pcap
  }

  trap "echo && finish && return 0" INT
  printf 'Hit [Any Key] to kill tcpdump'
  read -r
  finish
}
