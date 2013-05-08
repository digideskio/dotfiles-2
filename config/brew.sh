#!/bin/bash

# Install native apps here
export APP_DIR="/Applications"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

###############################################################################
# GNU Tools
###############################################################################
# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

###############################################################################
# OS X Tools
###############################################################################
brew install ack

# Install Bash 4
brew install bash
brew install bash-completion
brew install most
brew install tree

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

brew install rename
# Install wget with IRI support
brew install wget --enable-iri

###############################################################################
# Development
###############################################################################
brew install automake
brew install memcached
brew install git

#brew tap josegonzalez/homebrew-php
#brew install php54

# Python
brew install readline sqlite gdbm --universal
brew install python --universal --framework --with-brewed-openssl

###############################################################################
# Native Apps
###############################################################################
# Install native apps
brew tap phinze/homebrew-cask
brew install brew-cask

function cask_install() {
    if brew cask info "${@}" | grep "Not installed" > /dev/null; then
        brew cask install "${@}" --appdir="${APP_DIR}"
    else
        echo "${@} is already installed."
    fi
}

cask_install adium

cask_install app-cleaner

# Better insight into Time Machine and backups
#cask_install back-in-time

# Better gesture controls
cask_install bettertouchtool

# P2P file sharing/syncing
#cask_install bit-torrent-sync

#cask_install burn

# Keep the OS awake during presentations, etc.
#cask_install caffeine

# VNC client
#cask_install chicken

# Clipboard management tool
#cask_install clip-menu

cask_install dropbox

# Customize keys for USB joysticks and gamepads
#cask_install enjoy

cask_install firefox

# Hosts file manager
#cask_install gas-mask

# More featureful than Google's default notifier app
cask_install gmail-notifr

#cask_install google-notifier

cask_install google-chrome

cask_install google-chrome-canary

# Send Growl Notifications to Notification Center
#cask_install hiss

# Converts 24-bit PNG to paletted 8-bit with full alpha channel
#cask_install imagealpha

# Optimizes images so they take up less disk space and load faster
#cask_install imageoptim

cask_install iterm2

cask_install intellij-ultimate

# Wireless discovery tool
#cask_install i-stumbler

# Transfer songs from your iPod or iPhone to your Mac or PC
#cask_install irip

# Clipboard buffering
cask_install jumpcut

# Password management
cask_install keepass-x

# Convert almost any video to MP4, WebM (vp8), Ogg Theora, or for Android, iPhone, and iPad
#cask_install miro-video-converter

# Pixel art editor
#cask_install pixen

#cask_install postgres

# Productivity tool surpassing Spotlight
#cask_install quicksilver

cask_install sequel-pro

cask_install skype

cask_install sublime-text

# iTunes intergrated tagging
#cask_install tagalicious

# Change the default one-hour backup interval of Time Machine
cask_install time-machine-editor

# More capable replacement for "Archive Utility.app"
cask_install the-unarchiver

cask_install textwrangler

#cask_install tor-browser

# Torrent download manager
cask_install transmission

# Full disk encryption
#cask_install true-crypt

# Unicode keyboard layout editor
#cask_install ukelele

#cask_install virtualbox

cask_install vlc

# Globally capture whatever your mac is playing
#cask_install wav-tap

# Add Tabs and features to Mac Finder
cask_install xtra-finder

# Remove outdated versions from the cellar
brew cleanup
