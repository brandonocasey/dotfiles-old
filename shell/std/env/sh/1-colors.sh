#!/usr/bin/env bash

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
