# Make this script execution path-independent
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo_error() {
    echo -e "\x1B[00;31m$1\x1B[00m"
}

echo_nl() {
    echo -e "\n$1"
}

verify() {
    $* || (echo_error failed 1>&2 && exit 1)
}


###############################################################################
# Xcode
###############################################################################
# https://developer.apple.com/downloads/index.action

# Check that Xcode command line tools exist
clang_path=`which clang`
if [[ ! -f $clang_path ]]
then
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
if [[ ! -f $brew_path ]] then
    echo_nl "Installing Homebrew..."
    verify ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)
fi

echo_nl "Verifying Homebrew install..."
verify brew doctor

# If you get the error:
#   Error: No such file or directory - /usr/local/Cellar
# Run the following:
#   sudo mkdir /usr/local/Cellar
# and
#   sudo chown -R `whoami` /usr/local

echo_nl "Updating Homebrew..."
verify brew update

echo_nl "Upgrading Homebrew..."
verify brew upgrade

echo_nl "Installing Homebrew bash completion..."
ln -s "/usr/local/Library/Contributions/brew_bash_completion.sh" "/usr/local/etc/bash_completion.d"

###############################################################################
# RVM
###############################################################################
# https://rvm.io
curl -L https://get.rvm.io | bash -s stable --ruby

###############################################################################
# nave
###############################################################################
# https://github.com/isaacs/nave
# TODO: curl the nave.sh, symlink it into /bin and use that for initial node install
#npm install -g nave

###############################################################################
# z
###############################################################################
# https://github.com/rupa/z
# z, oh how i love you
#mkdir -p ~/code/z
#curl https://raw.github.com/rupa/z/master/z.sh > ~/code/z/z.sh
#chmod +x ~/code/z/z.sh

###############################################################################
# Pygments
###############################################################################
# for the c alias (syntax highlighted cat)
# TODO: Use pip install instead
#sudo easy_install Pygments
