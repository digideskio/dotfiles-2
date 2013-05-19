# Abort if not OS X
[[ "$OSTYPE" =~ ^darwin ]] || return 1

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
fi

###############################################################################
# Install Homebrew formulae and casks
###############################################################################
if [[ "$(type -P brew)" ]]; then
    source ~/.dotfiles/config/osx/brew.sh
fi
