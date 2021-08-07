# ----------------------------------------
#   Author: Liam Howell
#   Description: Bash configuration, aliases, functions etc
#
#   1. OPTIONS
#   2. EXPORTS
#   3. SOURCES
#   4. FUNCTIONS
#   5. ALIASES
#   6. PROMPT
#   7. GIT INTERCEPTOR
#   8. LOCAL SECRETS
# ----------------------------------------

# ----------------------------------------
#   1. OPTIONS
# ----------------------------------------

## Autocorrect typos in path names when using `cd`
shopt -s cdspell

## Save multi-line commands as one command
shopt -s cmdhist

## Autocorrect on directory names to match a glob.
shopt -s dirspell > /dev/null 2>&1

## Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar > /dev/null 2>&1

## Append to the history file rather then overwriting it
shopt -s histappend

## Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

## Reset output color from custom prompt back to white
trap "echo -ne '\033[0;37m'" DEBUG

# ----------------------------------------
#   2. EXPORTS
# ----------------------------------------

## Silence macOS bash deprecation message
export BASH_SILENCE_DEPRECATION_WARNING="1"

## Add color to terminal
export CLICOLOR="1"
export LSCOLORS="GxExBxBxFxegedabagacad"

## Set default editor
export EDITOR="nano"

## Set language and character encoding
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

## History options
export HISTSIZE="32768"
export HISTFILESIZE="${HISTSIZE}"
export HISTCONTROL="ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

## Manage Path
export PATH="$PATH:/usr/local/opt/mysql@5.7/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/.composer/vendor/bin"

## Set NVM Location
export NVM_DIR="$HOME/.nvm"

# ----------------------------------------
#   3. SOURCES
# ----------------------------------------

## Include NVM
[ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"

# ----------------------------------------
#   4. FUNCTIONS
# ----------------------------------------

## Create a new directory and enter it
function cdmkdir() {
  mkdir -p "$@" && cd "$_"
}

## Change working directory to the top-most Finder location
function cdfinder() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

## Change current working and change Node version if `.nvmrc` is present
function cdnvm() {
  cd "$@"

  local nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')
  local default_version=$(nvm version default)

  if [[ ! $nvm_path == *[^[:space:]]* ]]; then
    if [ ! $default_version = $(node -v) ]; then
      nvm use default --silent
    fi
  elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
    local nvm_version=$(<"$nvm_path"/.nvmrc)
    local resolved_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

    if [[ "$resolved_version" == "N/A" ]]; then
      nvm install "$nvm_version"
    elif [[ $(nvm current) != "$resolved_version" ]]; then
      nvm use "$nvm_version" --silent
    fi
  fi
}

## Direct output to /dev/null
function nullify() {
  "$@" > /dev/null 2>&1
}

## Open Finder at the current or supplied location
function openfinder() {
  if [ $# -eq 0 ]; then
    open "$PWD"
  else
    open "$@"
  fi
}

## Quick start a HTTP server from the current working directory
function serve() {
  php -S "localhost:${1:-3000}"
}

# ----------------------------------------
#   5. ALIASES
# ----------------------------------------

## Enable aliases to be sudo'd
alias sudo="sudo "

## Run last command with sudo
alias fuck="sudo $(fc -ln -1)"

## Completely clear the shell
alias clear="printf \"\033c\""

## Overwrite base `cd` function with `cdnvm` function
alias cd="cdnvm"

## Overwrite base `mkdir` function to also create parents if needed
alias mkdir="mkdir -pv"

## Overwrite base `open` function with `openfinder` function
alias open="openfinder"

## Overwrite base `cp` and`mv` funcions
alias cp="cp -v"
alias mv="mv -v"

## Navigation Shortcuts
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

## Quick navigation
alias desktop="cd $HOME/Desktop"
alias documents="cd $HOME/Documents"
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
alias cleandir="find . -name '*.DS_Store' -type f -ls -delete > /dev/null 2>&1"

## Hide/show hidden files
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder"

## Hide/show ~/Desktop files
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

## Print current IP address
alias getip="dig +short myip.opendns.com @resolver1.opendns.com"

## Updates
alias compup="composer global update"
alias brewup="brew update && brew upgrade && brew cleanup && brew cu"
alias hypeup="cd $HOME/.hyper_plugins && rm -rf node_modules && rm -f package-lock.json && npm install && cd -"
alias mcosup="mas upgrade && softwareupdate -i -a"
alias yarnup="yarn global upgrade"

# ----------------------------------------
#   6. PROMPT
# ----------------------------------------

## Include Prompt configuration
[ -s "$HOME/.bash_prompt" ] && source "$HOME/.bash_prompt"

# ----------------------------------------
#   7. GIT INTERCEPTOR
# ----------------------------------------

## Include Git Interceptor configuration
[ -s "$HOME/.bash_git" ] && source "$HOME/.bash_git"

# ----------------------------------------
#   8. LOCAL SECRETS
# ----------------------------------------

## Include local secrets
[ -s "$HOME/.localrc" ] && source "$HOME/.localrc"
