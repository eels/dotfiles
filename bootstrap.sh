#!/bin/zsh

# -----------------------------------------------
#   Author: Liam Howell
#   Description: Handles symlinks and dependency installation
#
#   0. BOOT
#   1. HOMEBREW
#   2. SYMLINKS
#   3. DIRECTORIES
#   4. CLEANUP
# -----------------------------------------------

# -----------------------------------------------
#   0. BOOT
# -----------------------------------------------

## Invalidate the current `sudo` timestamp file
sudo --reset-timestamp

## Ask for the administrator password upfront
sudo -v

## Keep-alive: update existing `sudo` time stamp until `bootstrap.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
_KEEPALIVE_PID=$!
trap 'kill "$_KEEPALIVE_PID" 2>/dev/null || true' EXIT

# -----------------------------------------------
#   1. HOMEBREW
# -----------------------------------------------

## Install Homebrew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

## Setup Homebrew directory permissions
for directory in "$(brew --prefix)" "$(brew --repository)"; do
  [ -d "$directory" ] && chown -R "$USER:$(id -gn)" "$directory" || true
done

## Install from Brewfile
brew bundle --file homebrew/brewfile

# -----------------------------------------------
#   2. SYMLINKS
# -----------------------------------------------

## Symlink dotfiles to the home directory
[ ! -L "$HOME/dotfiles" ] && ln -sf "$PWD" "$HOME/dotfiles"

## Create symlinks from config file
source "$PWD/bootstrap_symlinks.sh"

# -----------------------------------------------
#   3. DIRECTORIES
# -----------------------------------------------

## Create desired directories if they don't already exist
for directory in "Projects" "Sites"; do
  mkdir -p "$HOME/$directory"
done

# -----------------------------------------------
#   4. CLEANUP
# -----------------------------------------------

## Reload the shell
kill "$_KEEPALIVE_PID" 2>/dev/null || true
exec "${ZSH:-$(command -v zsh)}" -l
