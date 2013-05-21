# Abort if not Ubuntu
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1

source ~/.dotfiles/config/utils.sh

###############################################################################
# Update APT
###############################################################################
e_header "Updating APT..."
sudo apt-get -qq update
sudo apt-get -qq upgrade

###############################################################################
# Install APT packages
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
    "python-dev"
    "python-pip"
    "python-virtualenv"
    "virtualenvwrapper"
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

###############################################################################
# Install latest Node.js and Npm from custom repo
###############################################################################
# https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
sudo apt-get -qq install python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get -qq update
sudo apt-get -qq install nodejs