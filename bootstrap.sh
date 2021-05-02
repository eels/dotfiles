#!/bin/bash

# ----------------------------------------
#   Author: Liam Howell
#   Description: Handles symlinks and dependency installation
#
#   0. BOOT
#   1. HOMEBREW
#   2. SYMLINKS
#   3. NODE
#   4. COMPOSER & YARN GLOBALS
#   5. DIRECTORIES
#   6. APPLICATION ICONS
#   7. CLEANUP
# ----------------------------------------

# ----------------------------------------
#   0. BOOT
# ----------------------------------------

## Ask for the administrator password upfront
sudo -v

## Keep-alive: update existing `sudo` time stamp until `bootstrap.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ----------------------------------------
#   1. HOMEBREW
# ----------------------------------------

## Install Homebrew
if ! test $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

## Install from Brewfile
brew bundle --file homebrew/brewfile

# ----------------------------------------
#   2. SYMLINKS
# ----------------------------------------

## Symlink global composer.json to default location
ln -sf "$PWD/composer/composer.json" "$HOME/.composer/composer.json"

## Symlink global package.json to default location
ln -sf "$PWD/yarn/package.json" "$HOME/.config/yarn/global/package.json"

## Iterate through defined directories and symlink their files to `~`
for directory in "bash" "git" "hyper"; do
  for file in ./$directory/.*[a-zA-Z+]; do
    if [[ ! "${file##*/}" == *".example" ]]; then
      ln -sf "$PWD/$directory/${file##*/}" "$HOME/${file##*/}"
    fi
  done
done

## Symlink local secrets file if it exists
[ -s "$PWD/.localrc" ] && ln -sf "$PWD/.localrc" "$HOME/.localrc"

# ----------------------------------------
#   3. NODE
# ----------------------------------------

## Install latest Node versions
source "/usr/local/opt/nvm/nvm.sh" && nvm install node

# ----------------------------------------
#   4. COMPOSER & YARN GLOBALS
# ----------------------------------------

## Install globals for Composer
composer global upgrade

## Install globals for Yarn
yarn global upgrade

# ----------------------------------------
#   5. DIRECTORIES
# ----------------------------------------

## Create desired directories if they don't already exist
for directory in "Projects" "Sites"; do
  [ ! -d $HOME/$directory ] && mkdir $HOME/$directory
done

# ----------------------------------------
#   6. APPLICATION ICONS
# ----------------------------------------

## Execute Application icon setter
sudo node ./macos/.application_icons

## Kill/Refresh Finder and Dock
sudo killall Finder && sudo killall Dock

# ----------------------------------------
#   7. CLEANUP
# ----------------------------------------

exec ${SHELL} -l
