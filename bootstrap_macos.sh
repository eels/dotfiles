#!/bin/zsh

# ------------------------------------------------------
#   Author: Liam Howell
#   Description: Configure some macOS default settings
#
#   1. GENERAL UI/UX
#   2. ACCESSORIES AND INPUT
#   3. ENERGY SAVING
#   4. FINDER
#   5. DOCK AND DASHBOARD
#   6. ACTIVITY MONITOR
#   7. CLEANUP
# ------------------------------------------------------

# ------------------------------------------------------
#   1. GENERAL UI/UX
# ------------------------------------------------------

## Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

## Enable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true

## Enable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# -----------------------------------------------
#   2. ACCESSORIES AND INPUT
# -----------------------------------------------

## Trackpad: enable tap to click for this user and for the login screen
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

## Trackpad: map bottom right corner to right-click
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool false

## Disable "natural" scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# -----------------------------------------------
#   3. ENERGY SAVING
# -----------------------------------------------

## Enable lid wakeup
sudo pmset -a lidwake 1

## Restart automatically on power loss
sudo pmset -a autorestart 1

## Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

## Sleep the display after X minutes
sudo pmset -a displaysleep 10

## Set machine sleep to X minutes on battery
sudo pmset -a sleep 15

# -----------------------------------------------
#   4. FINDER
# -----------------------------------------------

## Set Home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"

## Hide icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

## Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

## Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

## Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5

## Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

## Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# -----------------------------------------------
#   5. DOCK AND DASHBOARD
# -----------------------------------------------

## Set the icon size of Dock items to 59 pixels
defaults write com.apple.dock tilesize -int 59

## Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

## Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

## Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

## Disable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# -----------------------------------------------
#   6. ACTIVITY MONITOR
# -----------------------------------------------

## Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

## Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

## Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 102

## Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# -----------------------------------------------
#   7. CLEANUP
# -----------------------------------------------

killall ActivityMonitor &> /dev/null
killall cfprefsd &> /dev/null
killall Dock &> /dev/null
killall Finder &> /dev/null
