# Abort if not OS X
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Utilities, helpers
source ~/.dotfiles/config/utils.sh

# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245
if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
    sudo xcode-select -switch /usr/bin
fi

###############################################################################
# Install Homebrew
###############################################################################
if [[ ! "$(type -P brew)" ]]; then
    e_header "Installing Homebrew..."
    true | ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)

    e_header "Verifying Homebrew..."
    brew doctor
fi

###############################################################################
# Install Homebrew formulae and casks
###############################################################################
if [[ "$(type -P brew)" ]]; then
    e_header "Updating and installing Homebrew formulae and casks..."
    if ! skip; then
        source ~/.dotfiles/config/osx/brew.sh
    fi
else
    e_error "Homebrew should be installed. It isn't. Aborting."
    exit 1
fi

# If you get the error:
#   Error: No such file or directory - /usr/local/Cellar
# Run the following:
#   sudo mkdir /usr/local/Cellar
# and
#   sudo chown -R `whoami` /usr/local

# If you get the error:
#   Error: Failed to import: arduino
#   Error: Failed to import: calibre
#   Error: Failed to import: frizzix
#   Error: Failed to import: ghostlab
#   Error: Failed to import: opera
# Run the following:
#   brew untap homebrew/versions
#   brew untap homebrew/dupes
#   brew untap phinze/cask
#   rm -rf /usr/local/Library/Taps/*
#   find /usr/local/Library/Formula -type l -delete

###############################################################################
# Set OS X defaults
###############################################################################
e_header "Setting OS X Defaults..."
if ! skip; then
    source ~/.dotfiles/config/osx/osx_defaults.sh
fi
