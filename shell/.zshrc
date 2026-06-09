#!/bin/zsh

# -----------------------------------------------
#   Author: Liam Howell
#   Description: ZSH configuration, aliases, functions etc
#
#   0. BOOT
#   1. OPTIONS
#   2. EXPORTS
#   3. PLUGINS
#   4. SOURCES
#   5. HOOKS
#   6. KEY BINDINGS
#   7. FUNCTIONS
#   8. OVERRIDES
#   9. ALIASES
#   0. PROMPT
#   1. GIT INTERCEPTOR
#   2. LOCAL SECRETS
# -----------------------------------------------

# -----------------------------------------------
#   0. BOOT
# -----------------------------------------------

## Clear the terminal on shell startup
clear

# -----------------------------------------------
#   1. OPTIONS
# -----------------------------------------------

## Autocorrect typos in path names when using `cd`
setopt CORRECT

## Do not print the working directory when using `cd`
setopt CD_SILENT

## Do not push duplicate directories on the stack
setopt PUSHD_IGNORE_DUPS

## Save the history after each command
setopt SHARE_HISTORY

## Ignore duplicates in history
setopt HIST_FIND_NO_DUPS

## Remove older instances of commands from the history
setopt HIST_IGNORE_ALL_DUPS

## Ensure consecutive duplicates don't get added to the history
setopt HIST_IGNORE_DUPS

## Ensure commands that start with a space don't get added to the history
setopt HIST_IGNORE_SPACE

## Ensure history is updated after each command
setopt HIST_SAVE_NO_DUPS

# -----------------------------------------------
#   2. EXPORTS
# -----------------------------------------------

## Add color to terminal
export CLICOLOR="1"
export LSCOLORS="GxExBxBxFxegedabagacad"

## Set default editor
export EDITOR="nano"

## Set language and character encoding
export LANG="en_GB.UTF-8"
export LANGUAGE="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

## History options
export HISTFILE="$HOME/.zsh_history"
export HISTORY_IGNORE="(exit|ls|bg|fg|history|clear)"
export HISTSIZE="32768"
export SAVEHIST="32768"

## Set Brew location
export BREW_DIR="/opt/homebrew/"

## Manage Path
export PATH="$BREW_DIR/bin:$PATH"
export PATH="$BREW_DIR/sbin:$PATH"

## Set Starship config location
export STARSHIP_CONFIG="$HOME/dotfiles/starship/starship.toml"

## Set Starship log level to error
export STARSHIP_LOG="error"

## Set Autosuggest config options
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"

## Set history highlight config options
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_TIMEOUT="0"

## Set default location for various user folders
export APPLICATION_SUPPORT="$HOME/Library/Application Support"

# -----------------------------------------------
#   3. PLUGINS
# -----------------------------------------------

## Load Sheldon Plugins
eval "$(sheldon source)"

## Load Completions
autoload -Uz compinit && compinit

# -----------------------------------------------
#   4. SOURCES
# -----------------------------------------------

export PATH="$PATH:$HOME/.asdf/shims"
export PATH="$PATH:$HOME/.yarn/bin"

# -----------------------------------------------
#   5. HOOKS
# -----------------------------------------------

## Ensure invalid and ignored commands don't get added to the history file
function zshaddhistory() {
  local trimmed_arg
  local cmd

  trimmed_arg="$(echo "$1" | xargs)"
  cmd="${trimmed_arg%% *}"

  if [[ $cmd == ${~HISTORY_IGNORE} ]]; then
    return 1
  fi

  whence "$cmd" >| /dev/null || return 1
}

zstyle ':completion:*' list-colors "${(s.:.)LSCOLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# -----------------------------------------------
#   6. KEY BINDINGS
# -----------------------------------------------

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# -----------------------------------------------
#   7. FUNCTIONS
# -----------------------------------------------

## Create an archive of a given directory
function archive() {
  local archive_path="${1:-$PWD}"

  if [[ ! -f $archive_path && ! -d $archive_path ]]; then
    echo "$archive_path is not a file or folder"
    return
  fi

  7z a "$(dirname "$archive_path")/$(basename "$archive_path").7z" "$archive_path" -xr!.DS_Store
}

## Set the modified date to equal the creation date of files of a given directory
function restoredate() {
  local target_path="${1:-$PWD}"

  for f in "$target_path"/*(N); do
    SetFile -m "$(GetFileInfo -d "$f")" "$f"
  done
}

## Copy the creation date of files of a given directory to the modified date
function copyvideodate() {
  local target_path="${1:-$PWD}"
  local output_path="${2:-$PWD}"

  if [[ ! -d $output_path ]]; then
    echo "$output_path is not a folder"
    return
  fi

  for f in "$target_path"/*(N); do
    SetFile -m "$(GetFileInfo -d "$f")" "$output_path/${$(basename "$f")/.mov/.mp4}"
  done
}

## Generate random password of a given length
function makepassword() {
  local length

  length="${1:-16}"

  openssl rand -base64 "$(($length * 2))" | cut -c1-$length | pbcopy
  pbpaste
}

## Change working directory to the top-most Finder location
function cdfinder() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || return
}

## Run last command with sudo
function fuck() {
  sudo "$(history -p !!)"
}

## Direct output to /dev/null
function nullify() {
  "$@" > /dev/null 2>&1
}

## Open Finder at the current or supplied location
function openfinder() {
  [ $# -eq 0 ] && "open" "$PWD" || "open" "$@"
}

## Determine size of a file or total size of a directory
function sizeof() {
  local arg

  du -b /dev/null > /dev/null 2>&1 && arg=-sbh || arg=-sh
  [[ -n "$*" ]] && du $arg -- "$@" || du $arg .[^.]* ./*
}

## Quick start a HTTP server from the current working directory
function serve() {
  python3 -m http.server --cgi ${1:-3000}
}

## Test the bootup time of the shell
function testshelltime() {
  local shell

  shell="${1-$SHELL}"

  for i in {1..10}; do
    /usr/bin/time "$shell" -i -c exit
  done
}

## Run the dotfiles bootstrap script in update mode
function dotupdate() {
  cd "$HOME/dotfiles" && bash "$HOME/dotfiles/bootstrap.sh" --update && cd -
}

# -----------------------------------------------
#   8. OVERRIDES
# -----------------------------------------------

## Override the `mkdir` function to create a directory and change into it
function __mkdir() {
  "mkdir" -pv "$@" && cd "$_" || return
}

# -----------------------------------------------
#   9. ALIASES
# -----------------------------------------------

## Enable aliases to be sudo'd
alias sudo="sudo "

## Run last command with sudo but be polite about it
alias please="fuck"

## Overwrite base `mkdir` function with `__mkdir` function
alias mkdir="__mkdir"

## Overwrite base `open` function with `openfinder` function
alias open="openfinder"

## Quick navigation
alias desktop="cd $HOME/Desktop"
alias documents="cd $HOME/Documents"
alias dotfiles="cd $HOME/dotfiles"
alias downloads="cd $HOME/Downloads"
alias home="cd $HOME"
alias projects="cd $HOME/Projects"
alias sites="cd $HOME/Sites"

## Print the current working directory
alias whereami="echo $PWD"

## Copy Public/Private SSH key to clipboard
alias getpubkey="pbcopy < $HOME/.ssh/id_ed25519.pub"

## Recursively delete `.DS_Store` files
alias cleandir="find $HOME -name '.DS_Store' -type f -delete > /dev/null 2>&1"

## Hide/show hidden files
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder"

## Hide/show ~/Desktop files
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

## Print current IP address
alias getip="dig +short myip.opendns.com @resolver1.opendns.com"
alias getlocalip="ipconfig getifaddr en0"

## Updates
alias appsup="mas upgrade"
alias brewup="brew update && brew upgrade && brew cleanup"
alias caskup="brew update && brew cu --cleanup --yes"
alias hypeup="cd $HOME/.hyper_plugins && rm -rf node_modules && rm -f package-lock.json && npm install && cd -"
alias softup="softwareupdate --all --install"
alias yarnup="cd $HOME/.config/yarn/global && rm -rf yarn.lock && yarn install && cd -"

## Open the dotfiles directory in vscode
alias code="code --reuse-window"
alias dotedit="code --reuse-window $HOME/dotfiles"

## Overwrite base `npx` function
alias npx="npx --yes"
alias ypx="npx"

## Reload the shell
alias reload="exec ${ZSH:-$(command -v zsh)} -l"

## Refresh the zsh environment
alias refresh="source $HOME/.zshrc"

# -----------------------------------------------
#   0. PROMPT
# -----------------------------------------------

## Include Prompt configuration
_evalcache starship init zsh

# -----------------------------------------------
#   1. GIT INTERCEPTOR
# -----------------------------------------------

## Include Git Interceptor configuration
[ -s "$HOME/.zsh_git" ] && source "$HOME/.zsh_git"

# -----------------------------------------------
#   2. LOCAL SECRETS
# -----------------------------------------------

## Include local secrets
[ -s "$HOME/.localrc" ] && source "$HOME/.localrc"
