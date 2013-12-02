#!/bin/bash

# Abort if not OS X
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Utilities, helpers
source ~/.dotfiles/config/utils.sh

# Install native apps here
APP_DIR="/Applications"

function brew_tap() {
    if ! brew tap | grep "${1}" > /dev/null; then
        brew tap "${1}"
    else
        echo "${1} is already tapped"
    fi
}

function brew_install() {
    for formula in "${formulae[@]}"; do
        set $formula
        if brew info "${1}" | grep "Not installed" > /dev/null; then
            brew install ${formula}
        else
            echo "${1} is already installed"
        fi
    done
}

function cask_install() {
    for cask in "${casks[@]}"; do
        set $cask
        if brew cask info "${1}" | grep "Not installed" > /dev/null; then
            brew cask install --appdir="${APP_DIR}" "${cask}"
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
#brew_tap homebrew/completions
brew_tap phinze/cask
#brew_tap josegonzalez/homebrew-php

###############################################################################
# Install Homebrew formulae
###############################################################################
e_header "Installing Homebrew Formula..."

formulae=(
    #=====================
    # GNU Tools
    #=====================
    "coreutils"
    "findutils" # Installs `find`, `locate`, `updatedb`, and `xargs` ('g' prefixed)
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
    "z"
    #=====================
    # Development Tools
    #=====================
    "homebrew/dupes/apple-gcc42"
    "cloc" # Counts blank lines, comment lines, and physical lines of source code
    "wget --enable-iri"
    "sqlite --universal"
    "gdbm --universal"
    "python --universal --framework --with-brewed-openssl"
    "git"
    "git-extras"
    "svn"
    "nodejs"
    "npm"
    #"php54"
    "mysql"
    "mongodb"
    "redis"
    "memcached"
    "rabbitmq"
    "ruby-build"
    "rbenv"
    "rbenv-default-gems"
    "s3cmd" # Command line tool for uploading, retrieving and managing data in Amazon S3
    "elasticsearch"
    "heroku-toolbelt"
    "ansible"
    "unixodbc"
)
brew_install "${formulae[@]}"

###############################################################################
# Notes
###############################################################################

#=====================
# elasticsearch
#=====================
# Data:    /usr/local/var/elasticsearch/elasticsearch_misha/
# Logs:    /usr/local/var/log/elasticsearch/elasticsearch_misha.log
# Plugins: /usr/local/var/lib/elasticsearch/plugins/
#
# To have launchd start elasticsearch at login:
#     ln -sfv /usr/local/opt/elasticsearch/*.plist ~/Library/LaunchAgents
# Then to load elasticsearch now:
#     launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
# Or, if you don't want/need launchctl, you can just run:
#     elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml

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
    appcleaner
    ansible
    #back-in-time # Better insight into Time Machine and backups
    bettertouchtool # Better gesture controls
    #bit-torrent-sync # P2P file sharing/syncing
    #burn
    caffeine # Keep the OS awake during presentations, etc.
    #chicken # VNC client
    #clip-menu # Clipboard management tool
    cyberduck
    dropbox
    disk-inventory-x
    #enjoy # Customize keys for USB joysticks and gamepads
    firefox
    #gas-mask # Hosts file manager
    github
    gmail-notifr # More featureful than Google's default notifier app
    #google-notifier
    google-chrome
    graphicsmagick
    #google-chrome-canary
    google-drive
    #hiss # Send Growl Notifications to Notification Center
    #imagealpha # Converts 24-bit PNG to paletted 8-bit with full alpha channel
    #imageoptim # Optimizes images so they take up less disk space and load faster
    iterm2
    intellij-ultimate
    #i-stumbler # Wireless discovery tool
    #irip # Transfer songs from your iPod or iPhone to your Mac or PC
    jumpcut # Clipboard buffering
    keepassx # Password management
    #miro-video-converter # Convert almost any video to MP4, WebM (vp8), Ogg Theora, or for Android, iPhone, and iPad
    parallels-8
    #pixen # Pixel art editor
    #postgres
    #quicksilver # Productivity tool surpassing Spotlight
    sequel-pro
    skype
    sublime-text
    #time-machine-editor # Change the default one-hour backup interval of Time Machine
    the-unarchiver # More capable replacement for "Archive Utility.app"
    textwrangler
    #trim-enabler
    #tor-browser
    transmission # Torrent download manager
    true-crypt # Full disk encryption
    #ukelele # Unicode keyboard layout editor
    # /opt/homebrew-cask/Caskroom/virtualbox/4.2.12-84980/VirtualBox.pkg
    vagrant
    virtualbox # (** Requires manual package installation **)
    vlc
    webstorm
    #wav-tap # Globally capture whatever your mac is playing
    xtrafinder # Add Tabs and features to Mac Finder (** Requires manual package installation **)
)
cask_install "${casks[@]}"

###############################################################################
# Cleanup
###############################################################################
# Remove outdated versions from the cellar
brew cleanup
