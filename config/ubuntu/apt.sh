# Abort if not Ubuntu
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1

source ~/.dotfiles/config/utils.sh

###############################################################################
# Update APT
###############################################################################
e_header "Updating & upgrading APT..."
sudo apt-get -qq update
sudo apt-get -qq upgrade

e_header "Adding APT repositories..."
# Node.js & Npm
# https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
sudo add-apt-repository ppa:chris-lea/node.js
# Java
sudo add-apt-repository ppa:webupd8team/java

sudo apt-get -qq update

###############################################################################
# Install APT packages (order matters)
###############################################################################
packages=(
    "build-essential"
    "libssl-dev"
    "tree"
    "telnet"
    "htop"
    "nmap"
    "git"
    "git-extras"
    "oracle-java6-installer"
    "python-software-properties"
    "python"
    "python-dev"
    "python-pip"
    "python-virtualenv"
    "virtualenvwrapper"
    "nodejs"
    "rbenv"
    "ruby-build"
    "rubygems"
    "mysql-server"
    "memcached"
    "rabbitmq-server"
)

list=()
for package in "${packages[@]}"; do
    if [[ ! "$(dpkg -l "$package" 2>/dev/null | grep "^ii  $package")" ]]; then
        list=("${list[@]}" "$package")
    fi
done

if ((${#list[@]} > 0)); then
    e_header "Installing APT packages: ${list[*]}"
    for package in "${list[@]}"; do
        sudo apt-get -qq install "$package"
    done
fi
