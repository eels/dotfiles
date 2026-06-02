#!/bin/bash

# -----------------------------------------------
#   Author: Liam Howell
#   Description: Handles symlinks and dependency installation
#
#   0. BOOT
#   1. HOMEBREW
#   2. SYMLINKS
#   3. NODE
#   4. DIRECTORIES
#   5. CLEANUP
# -----------------------------------------------

# -----------------------------------------------
#   0. BOOT
# -----------------------------------------------

## Set flag to say if this is an initial run or an update
[[ "$*" == *"--update"* ]] && IS_UPDATING=true || IS_UPDATING=false

## Invalidate the current `sudo` timestamp file
sudo --reset-timestamp

## Ask for the administrator password upfront
sudo -v

## Keep-alive: update existing `sudo` time stamp until `bootstrap.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# -----------------------------------------------
#   1. HOMEBREW
# -----------------------------------------------

## Install Homebrew
if ! test "$(brew -v)"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

## Setup Homebrew directory permissions
for directory in "$(brew --prefix)" "$(brew --repository)"; do
  [ -d "$directory" ] && chown -R "$USER:admin" "$directory" > /dev/null 2>&1
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
  [ -s "$PWD" ] && ln -sf "$PWD" "$HOME/dotfiles"
fi

## Symlink `asdf` .asdfrc && .tool-versions to default location
ln -sf "$PWD/asdf/.asdfrc" "$HOME/.asdfrc"
ln -sf "$PWD/asdf/.tool-versions" "$HOME/.tool-versions"

## Iterate through defined directories and symlink their files to `~`
for directory in "git" "shell"; do
  for file in ./"$directory"/.*[a-zA-Z+]; do
    if [[ ! "${file##*/}" == *".example" ]]; then
      ln -sf "$PWD/$directory/${file##*/}" "$HOME/${file##*/}"
    fi
  done
done

## Symlink local secrets file if it exists
[ -s "$PWD/shell/.localrc" ] && ln -sf "$PWD/shell/.localrc" "$HOME/.localrc"

## Create + symlink Ghostty directory + config file
[ ! -d "$HOME/.config/ghostty" ] && mkdir "$HOME/.config/ghostty"
ln -sf "$PWD/ghostty/config.ghostty" "$HOME/.config/ghostty/config.ghostty"

## Create + symlink OpenCode directory
[ ! -d "$HOME/.config/opencode" ] && mkdir "$HOME/.config/opencode"
ln -sf "$PWD/opencode/agents" "$HOME/.config/opencode/agents"
ln -sf "$PWD/opencode/skills" "$HOME/.config/opencode/skills"

## Create + symlink Sheldon directory + plugin file
[ ! -d "$HOME/.config/sheldon" ] && mkdir "$HOME/.config/sheldon"
ln -sf "$PWD/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

# -----------------------------------------------
#   3. NODE
# -----------------------------------------------

## Install latest Node versions
if [ "$IS_UPDATING" == false ]; then
  fnm install --latest
fi

# -----------------------------------------------
#   4. DIRECTORIES
# -----------------------------------------------

## Create desired directories if they don't already exist
for directory in "Projects" "Sites"; do
  [ ! -d "$HOME/$directory" ] && mkdir "$HOME/$directory"
done

# -----------------------------------------------
#   5. CLEANUP
# -----------------------------------------------

## Reload the shell
exec "$(which zsh)" -l
