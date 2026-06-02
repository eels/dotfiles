#!/bin/bash
set -euo pipefail

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

## Set flag to say if this is an initial run or an update
IS_UPDATING=false

for arg in "$@"; do
  [ "$arg" = "--update" ] && IS_UPDATING=true
done

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
if [ "$IS_UPDATING" == false ]; then
  brew bundle --file homebrew/brewfile
fi

# -----------------------------------------------
#   2. SYMLINKS
# -----------------------------------------------

## Symlink dotfiles to the home directory
if [ "$IS_UPDATING" == false ]; then
  [ ! -L "$HOME/dotfiles" ] && ln -sf "$PWD" "$HOME/dotfiles"
fi

## Iterate through defined directories and symlink their files to `~`
shopt -s nullglob
for directory in "git" "shell"; do
  for file in ./"$directory"/.*[a-zA-Z+]; do
    if [[ ! "${file##*/}" == *".example" ]]; then
      ln -sf "$PWD/$directory/${file##*/}" "$HOME/${file##*/}"
    fi
  done
done
shopt -u nullglob

## Symlink `asdf` .asdfrc && .tool-versions to default location
ln -sf "$PWD/asdf/.asdfrc" "$HOME/.asdfrc"
ln -sf "$PWD/asdf/.tool-versions" "$HOME/.tool-versions"

## Symlink local secrets file if it exists
[ -s "$PWD/shell/.localrc" ] && ln -sf "$PWD/shell/.localrc" "$HOME/.localrc"

## Create + symlink Ghostty directory + config file
mkdir -p "$HOME/.config/ghostty"
ln -sf "$PWD/ghostty/config.ghostty" "$HOME/.config/ghostty/config.ghostty"

## Create + symlink OpenCode directory
mkdir -p "$HOME/.config/opencode"
ln -sf "$PWD/opencode/agents" "$HOME/.config/opencode/agents"
ln -sf "$PWD/opencode/skills" "$HOME/.config/opencode/skills"

## Create + symlink Sheldon directory + plugin file
mkdir -p "$HOME/.config/sheldon"
ln -sf "$PWD/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

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
