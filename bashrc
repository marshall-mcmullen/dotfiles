#----------------------------------------------------------------------------------------------------------------------
#
# System Configuration
#
#----------------------------------------------------------------------------------------------------------------------

# Path to your oh-my-bash installation.
export OSH=${HOME}/.oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  makefile
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $OSH/oh-my-bash.sh

#----------------------------------------------------------------------------------------------------------------------
#
# User Configuration
#
#----------------------------------------------------------------------------------------------------------------------

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

DEFAULT_USER=mmcmullen

# If brew is installed add it to our path as necessary
BREW_PATH="$(which brew 2>/dev/null)"
if [[ -n "${BREW_PATH}" ]]; then
    BREW_PATH="${BREW_PATH%/bin/brew}"
fi

## Path
path=(
    ~/bin
    ~/code/go/bin
    ~/code/ebash/bin
    ~/.local/bin
    ~/.gem/ruby/current/bin
    "${BREW_PATH}/opt/make/libexec/gnubin"
    "${BREW_PATH}/opt/coreutils/libexec/gnubin"
    ${PATH}
)
PATH=$(echo "${path[@]}" | sed -e 's| |:|g')

cdpath=(
    ~
    ~/code/liqid
    ~/code/sf
    ~/code/automox
    ~/code
    ${CDPATH}
)
CDPATH=$(echo "${cdpath[@]}" | sed -e 's| |:|g')

## Aliases
EDITOR="nvim"
alias ls='ls --color'
alias vimdiff='nvim -d'
alias kj='kill -9 %1'
alias diff='colordiff'

# If not running interactively, don't do anything
# ! shopt -oq posix; then
[[ $- != *i* ]] && return

# Load keychain
eval $(keychain --eval --lockwait 120 --inherit any --agents ssh id_rsa)

## History
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Show pending updates
if [[ -f ~/.brew-updates.txt ]]; then
    cat ~/.brew-updates.txt
fi

# Make
export MAKEFLAGS="-j $(nproc)"

# Go
export GOPATH=~/code/go
export GOPRIVATE=github.com/reserve-trust/*

# Docker
#export DOCKER_HOST=ssh://marshall@asgard

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

return 0

# vim: textwidth=120 colorcolumn=120
