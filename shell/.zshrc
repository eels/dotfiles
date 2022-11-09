#!/bin/zsh

# -----------------------------------------------
#   Author: Liam Howell
#   Description: ZSH configuration, aliases, functions etc
#
#   1. OPTIONS
#   2. EXPORTS
#   3. PLUGINS
#   4. SOURCES
#   5. FUNCTIONS
#   6. ALIASES
#   7. PROMPT
#   8. GIT INTERCEPTOR
#   9. LOCAL SECRETS
# -----------------------------------------------

# -----------------------------------------------
#   1. OPTIONS
# -----------------------------------------------

## Autocorrect typos in path names when using `cd`
setopt CORRECT

## Do not print the working directory when using `cd`
setopt CD_SILENT

## Do not push duplicate directories on the stack
setopt PUSHD_IGNORE_DUPS

## Append to the history file rather then overwriting it
setopt INC_APPEND_HISTORY

## Ignore duplicates in history
setopt HIST_FIND_NO_DUPS

## Remove older instances of commands from the history
setopt HIST_IGNORE_ALL_DUPS

## Ensure consecutive duplicates don't get added to the history
setopt HIST_IGNORE_DUPS

## Ensure commands that start with a space don't get added to the history
setopt HIST_IGNORE_SPACE

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
export HISTCONTROL="ignoreboth"
export HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE="${HISTSIZE}"
export HISTSIZE="32768"
export HISTORY_IGNORE="(exit|ls|bg|fg|history|clear)"
export SAVEHIST="32768"

## Set NVM location
export NVM_DIR="$HOME/.nvm"

## Set Brew location
export BREW_DIR="/usr/local"

## Manage Path
export PATH="$PATH:$BREW_DIR/bin"
export PATH="$PATH:$BREW_DIR/sbin"
export PATH="$PATH:$HOME/.composer/vendor/bin"

## Set PHP Version location
export PHPV_DIR="$(brew --prefix php-version)"

## Set Starship config location
export STARSHIP_CONFIG="$HOME/dotfiles/starship/starship.toml"

## Set Autosuggest config options
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"

# -----------------------------------------------
#   3. PLUGINS
# -----------------------------------------------

## Load Sheldon Plugins
eval "$(sheldon source)"

## Load Completions
autoload compinit && compinit

# -----------------------------------------------
#   4. SOURCES
# -----------------------------------------------

## Include NVM
lazyload node nvm npm npx yarn -- 'source "$BREW_DIR/opt/nvm/nvm.sh"'

## Include PHP Version
lazyload composer php -- 'source "$PHPV_DIR/php-version.sh"'

# -----------------------------------------------
#   5. FUNCTIONS
# -----------------------------------------------

## Create an archive of a given directory
function archive() {
  local archive_path

  [ $# -eq 0 ] && archive_path=$PWD || archive_path=$1

  if [[ ! -f $archive_path && ! -d $archive_path ]]; then
    echo "$archive_path is not a file or folder"
    return
  fi

  7z a "$(basename "$archive_path").7z" "$archive_path" -xr!.DS_Store
  mv "$(basename "$archive_path").7z" "$(dirname "$archive_path")" > /dev/null 2>&1
}

## Generate random password of a given length
function makepassword() {
  local length="${1:-16}"

  openssl rand -base64 "$(($length * 2))" | cut -c1-$length | pbcopy
  pbpaste
}

## Change working directory to the top-most Finder location
function cdfinder() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || exit
}

## Create a new directory and enter it
function cdmkdir() {
  "mkdir" -pv "$@" && cd "$_" || exit
}

## Change current working and change Node version if `.nvmrc` is present
function cdnvm() {
  "cd" "$@" || return

  local nvm_path="$(nvm_find_up .nvmrc | tr -d '\n')"

  if [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
    local nvm_version="$(<"$nvm_path"/.nvmrc)"
    local resolved_version="$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')"

    if [[ "$resolved_version" == "N/A" ]]; then
      nvm install "$nvm_version"
    elif [[ "$(nvm current)" != "$resolved_version" ]]; then
      nvm use "$nvm_version" --silent
    fi
  fi

  if [[ ! $nvm_path == *[^[:space:]]* ]]; then
    if [ -z "$(nvm alias default)" ]; then
      nvm alias default node
    fi

    local default_version="$(nvm version default)"

    if [ ! "$default_version" = "$(node -v)" ]; then
      nvm use default --silent
    fi
  fi
}

## Run last command with sudo
function fuck() {
  sudo "$(history -p !!)"
}

## Kill the running process running the on specified port
function killport() {
  local pid

  pid=$(lsof -n -i4TCP:"$1" | awk 'NR==1{print $11}')

  kill -9 "$pid" > /dev/null 2>&1
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
  php -S "localhost:${1:-3000}"
}

## Test the bootup time of the shell
function testshelltime() {
  local shell="${1-$SHELL}"

  for i in $(seq 1 10); do
    /usr/bin/time "$shell" -i -c exit
  done
}

## Update application icons using script from `macos` directory
function updateicons() {
  node "$HOME/dotfiles/macos/application_icons"
  killall Finder && killall Dock
}

## Run the dotfiles bootstrap script in update mode
function dotupdate() {
  cd "$(readlink -f "$HOME/dotfiles")"
  bash "$(readlink -f "$HOME/dotfiles/bootstrap.sh")" --update && cd -
}

# -----------------------------------------------
#   6. ALIASES
# -----------------------------------------------

## Enable aliases to be sudo'd
alias sudo="sudo "

## Run last command with sudo but be polite about it
alias please="fuck"

## Completely clear the shell
alias clear="printf \"\033c\""

## Overwrite base `cd` function with `cdnvm` function
alias cd="cdnvm"

## Overwrite base `mkdir` function with `cdmkdir` function
alias mkdir="cdmkdir"

## Overwrite base `open` function with `openfinder` function
alias open="openfinder"

## Overwrite base `cp` and`mv` funcions
alias cp="cp -v"
alias mv="mv -v"

## Navigation shortcuts
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

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
alias getprikey="pbcopy < $HOME/.ssh/id_ed25519"

## Recursively delete `.DS_Store` files
alias cleandir="find / -name '*.DS_Store' -type f -ls -delete > /dev/null 2>&1"

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
alias compup="composer global update"
alias hypeup="cd $HOME/.hyper_plugins && rm -rf node_modules && rm -f package-lock.json && npm install && cd -"
alias softup="softwareupdate --all --install"
alias yarnup="cd $HOME/.config/yarn/global && rm -rf yarn.lock && yarn install && cd -"

## Open the dotfiles directory in vscode
alias dotedit="code --add $(readlink -f "$HOME/dotfiles") --reuse-window"

## Overwrite base `npx` function
alias npx="npx --yes"
alias ypx="npx"

## Reload the shell
alias reload="exec $(which zsh) -l && clear"

## Refresh the zsh environment
alias refresh="source $HOME/.zshrc"

# -----------------------------------------------
#   7. PROMPT
# -----------------------------------------------

## Include Prompt configuration
eval "$(starship init zsh)"

# -----------------------------------------------
#   8. GIT INTERCEPTOR
# -----------------------------------------------

## Include Git Interceptor configuration
[ -s "$HOME/.zsh_git" ] && source "$HOME/.zsh_git"

# -----------------------------------------------
#   9. LOCAL SECRETS
# -----------------------------------------------

## Include local secrets
[ -s "$HOME/.localrc" ] && source "$HOME/.localrc"
