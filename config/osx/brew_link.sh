#!/bin/bash

# Abort if not OS X
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Utilities, helpers
source ~/.dotfiles/config/utils.sh

e_header "Linking Hombrewed apps and cleaning..."
# Ommiting native linkapps because they make Spotlight unreachable symlinks
# brew linkapps --system
# brew cask linkapps
osascript ~/.dotfiles/config/osx/BrewLinkApps.scpt
osascript ~/.dotfiles/config/osx/CaskLinkApps.scpt
brew cleanup