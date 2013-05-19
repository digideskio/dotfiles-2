#!/bin/bash

# Abort if not OS X
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Utilities, helpers
source ~/.dotfiles/source/.functions

# Install native apps here
APP_DIR="/Applications"

function brew_tap() {
    brew tap "${1}" | grep "Already tapped" > /dev/null
}

function brew_install() {
    for formula in "${formulae[@]}"; do
        set $formula
        if brew info "${1}" | grep "Not installed" > /dev/null; then
            brew install "${formula}"
        else
            echo "${1} is already installed"
        fi
    done
}

function cask_install() {
    for cask in "${casks[@]}"; do
        set $cask
        if brew cask info "${1}" | grep "Not installed" > /dev/null; then
            brew cask install "${cask} --app-dir=${APP_DIR}"
        else
            echo "${1} is already installed"
        fi
    done
}

###############################################################################
# Update Homebrew and upgrade formulae
###############################################################################
# Make sure we’re using the latest Homebrew
e_header "Updating Homebrew..."
brew update

# Upgrade existing formulae
e_header "Upgrading installed formulae..."
if ! skip; then
    brew upgrade
fi

###############################################################################
# Tap Homebrew repositories
###############################################################################
e_header "Tap Homebrew Repos..."

brew_tap homebrew/dupes
brew_tap homebrew/versions
brew_tap phinze/homebrew-cask
#brew_tap josegonzalez/homebrew-php

e_header "Installing Homebrew Casks..."

###############################################################################
# Install Homebrew formulae
###############################################################################
e_header "Installing Homebrew Formula..."

formulae=(
    #=====================
    # GNU Tools
    #=====================
    "coreutils"
    "findutils" # Installs `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
    "automake" # Automatically generates `Makefile.in' files compliance with the GNU
    #=====================
    # OS X Tools
    #=====================
    "ack"
    "bash" # Bash 4
    "bash-completion"
    "most"
    "tree"
    "sl"
    "pv" # Monitors the progress of data through a pipeline
    "readline"
    "homebrew/dupes/grep"
    "brew-cask" # Installs native apps
    #=====================
    # Development Tools
    #=====================
    #"homebrew/dupes/apple-gcc42"
    "wget --enable-iri"
    "sqlite --universal"
    "gdbm --universal"
    "python24 --universal --framework --with-brewed-openssl"
    "git"
    "git-extras"
    "svn"
    "npm"
    "php54"
    "mysql"
    "memcached"
    "rabbitmq"
)
brew_install "${formulae[@]}"

###############################################################################
# Notes
###############################################################################
#=====================
# memcached
#=====================
# To have launchd start memcached at login:
#     ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents
# Then to load memcached now:
#     launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist
# Or, if you don't want/need launchctl, you can just run:
#     /usr/local/opt/memcached/bin/memcached

#=====================
# mysql
#=====================
# To connect:
#     mysql -uroot
# To have launchd start mysql at login:
#     ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
# Then to load mysql now:
#     launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
# Or, if you don't want/need launchctl, you can just run:
#     mysql.server start


###############################################################################
# Install Homebrew Casks
###############################################################################
e_header "Installing Homebrew Casks..."
casks=(
    adium
    app-cleaner
    #back-in-time # Better insight into Time Machine and backups
    bettertouchtool # Better gesture controls
    #bit-torrent-sync # P2P file sharing/syncing
    #burn
    #caffeine # Keep the OS awake during presentations, etc.
    #chicken # VNC client
    #clip-menu # Clipboard management tool
    dropbox
    #enjoy # Customize keys for USB joysticks and gamepads
    firefox
    #gas-mask # Hosts file manager
    github
    gmail-notifr # More featureful than Google's default notifier app
    #google-notifier
    google-chrome
    google-chrome-canary
    google-drive
    #hiss # Send Growl Notifications to Notification Center
    #imagealpha # Converts 24-bit PNG to paletted 8-bit with full alpha channel
    #imageoptim # Optimizes images so they take up less disk space and load faster
    iterm2
    intellij-ultimate
    #i-stumbler # Wireless discovery tool
    #irip # Transfer songs from your iPod or iPhone to your Mac or PC
    jumpcut # Clipboard buffering
    keepass-x # Password management
    #miro-video-converter # Convert almost any video to MP4, WebM (vp8), Ogg Theora, or for Android, iPhone, and iPad
    #pixen # Pixel art editor
    #postgres
    #quicksilver # Productivity tool surpassing Spotlight
    sequel-pro
    skype
    sublime-text
    #tagalicious # iTunes intergrated tagging
    time-machine-editor # Change the default one-hour backup interval of Time Machine
    the-unarchiver # More capable replacement for "Archive Utility.app"
    textwrangler
    trim-enabler
    #tor-browser
    transmission # Torrent download manager
    #true-crypt # Full disk encryption
    #ukelele # Unicode keyboard layout editor
    # FIXME: VirtualBox requires the package to be manually installed
    # /opt/homebrew-cask/Caskroom/virtualbox/4.2.12-84980/VirtualBox.pkg
    virtualbox
    vlc
    #wav-tap # Globally capture whatever your mac is playing
    # FIXME: XtraFinder requires the package to be manually installed
    # /opt/homebrew-cask/Caskroom/xtra-finder/latest/XtraFinder.pkg
    xtra-finder # Add Tabs and features to Mac Finder
)
cask_install "${casks[@]}"

if brew cask info trim-enabler | grep "Not installed" > /dev/null; then
    e_header "Installing Homebrew Cask: trim-enabler"
    brew cask install https://raw.github.com/jcrafford/dotfiles/master/config/osx/Casks/trim-enabler.rb
fi

###############################################################################
# Cleanup
###############################################################################
# Remove outdated versions from the cellar
brew cleanup
