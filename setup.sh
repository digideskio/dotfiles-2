#!/bin/bash

echo_success() {
    echo -e "\n\x1B[00;32m$1\x1B[00m"
}

echo_info() {
    echo -e "\n\x1B[00;34m$1\x1B[00m"
}

echo_warning() {
    echo -e "\n\x1B[00;33m$1\x1B[00m"
}

echo_error() {
    echo -e "\n\x1B[00;31m$1\x1B[00m"
}

verify() {
    $* || (echo_error failed 1>&2 && exit 1)
}

###############################################################################
# Personal Configuration
###############################################################################
export GITHUB_MAIL="jcrafford@gmail.com"

# Create personal directories
mkdir ~/Projects 2> /dev/null
mkdir ~/Tools 2> /dev/null

###############################################################################
# Xcode (Manual install)
###############################################################################
# https://developer.apple.com/downloads/index.action

# Check that Xcode command line tools exist
echo_info "Checking for Xcode command line tools..."
clang_path=`which clang`
if [[ ! -f $clang_path ]]; then
    echo_error "You need Xcode command line tools to proceed:"
    echo "https://developer.apple.com/downloads/index.action"
    exit -1
fi

###############################################################################
# Homebrew
###############################################################################
# http://mxcl.github.io/homebrew/
# Requires Xcode CLI tools

brew_path=`which brew`
if [[ ! -f $brew_path ]]; then
    echo_info "Installing Homebrew..."
    verify ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)
fi

echo_info "Verifying Homebrew..."
verify brew doctor

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

echo_info "Updating Homebrew..."
verify brew update

echo_info "Upgrading Homebrew..."
verify brew upgrade

echo_info "Installing Homebrew Formulae and Casks (this may take a while)..."
chmod +x config/brew.sh
config/brew.sh

# FIXME: Source .bash_profile or .path now to get updated path before proceeding?

###############################################################################
# Python, pip, Virtualenv, Virtualenvwrapper
###############################################################################
if [[ ! -f /usr/local/bin/python ]]; then
    echo_info "Linking Python framework..."
    ln -s "/usr/local/Cellar/python/2.7.4/Frameworks/Python.framework" ~/Frameworks

    echo_info "Upgrading Distribute and pip..."
    pip install --upgrade distribute
    pip install --upgrade pip

    echo_info "Installing pip tools..."
    # pip-tools includes:
    #   pip-review - reports available updates
    #   pip-dump - generates requirements.txt
    pip install pip-tools

    echo_info "Installing virtualenv and virtualenvwrapper..."
    pip install virtualenv
    pip install virtualenvwrapper
fi

###############################################################################
# Git
###############################################################################
echo_info "Checking for SSH key, generating one if it doesn't exist ..."
[[ -f ~/.ssh/id_rsa.pub ]] || ssh-keygen -t rsa -C "$GITHUB_MAIL" -f ~/.ssh/id_rsa

echo_warning "Copying public key to clipboard. Paste it into your Github account ..."
[[ -f ~/.ssh/id_rsa.pub ]] && cat ~/.ssh/id_rsa.pub | pbcopy
verify open https://github.com/settings/ssh

echo_warning "Accept Github fingerprint: (16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48)"
ssh -T git@github.com

###############################################################################
# RVM
###############################################################################
# https://rvm.io
# Requires automake formula
rvm_path=`which rvm`
if [[ ! -f rvm_path ]]; then
    echo_info "Installing RVM..."
    verify curl -L https://get.rvm.io | bash -s stable --ruby
fi

###############################################################################
# nave
###############################################################################
# https://github.com/isaacs/nave
# TODO: curl the nave.sh, symlink it into /bin and use that for initial node install
#npm install -g nave
#nave_path=`which nave`
#if [[ ! -f nave_path ]]; then
#    echo_info "Installing nave..."
#    verify ???
#fi

###############################################################################
# LESS CSS
###############################################################################
# http://lesscss.org/
less_path=`which less`
if [[ ! -f less_path ]]; then
    echo_info "Installing LESS CSS..."
    verify npm install -g less
fi

###############################################################################
# nginx
###############################################################################
# http://learnaholic.me/2012/10/10/installing-nginx-in-mac-os-x-mountain-lion/
# https://openmile.unfuddle.com/a#/projects/1/notebooks/2/pages/195/latest

###############################################################################
# MySQL
###############################################################################
# http://madebyhoundstooth.com/blog/install-mysql-on-mountain-lion-with-homebrew/
# https://openmile.unfuddle.com/a#/projects/1/notebooks/2/pages/13/latest

###############################################################################
# RabbitMQ
###############################################################################
# https://openmile.unfuddle.com/a#/projects/1/notebooks/2/pages/122/latest

###############################################################################
# MemcacheQ
###############################################################################
# https://openmile.unfuddle.com/a#/projects/1/notebooks/2/pages/91/latest

###############################################################################
# z
###############################################################################
# https://github.com/rupa/z
# z, oh how i love you
#mkdir -p ~/Tools/z
#curl https://raw.github.com/rupa/z/master/z.sh > ~/code/z/z.sh
#chmod +x ~/Tools/z/z.sh

###############################################################################
# Configure OS X
###############################################################################
echo_info "Configuring OSX..."
chmod +x config/osx.sh
osx.sh

echo_success "Setup complete!"