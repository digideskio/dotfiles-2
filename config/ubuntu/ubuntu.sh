# Abort if not Ubuntu
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1

source ~/.dotfiles/config/utils.sh

###############################################################################
# Install suoders file
###############################################################################
# If the old files isn't removed, the duplicate APT alias will break sudo!
sudoers_old="/etc/sudoers.d/sudoers-justin"; [[ -e "$sudoers_old" ]] && sudo rm "$sudoers_old"

# Installing this sudoers file makes life easier
sudoers_file="sudoers-dotfiles"
sudoers_src=~/.dotfiles/config/ubuntu/$sudoers_file
sudoers_dest="/etc/sudoers.d/$sudoers_file"

if [[ ! -e "$sudoers_dest" || "$sudoers_dest" -ot "$sudoers_src" ]]; then
  cat <<EOF
The sudoers file can be updated to allow certain commands to be executed
without needing to use sudo. This is potentially dangerous and should only
be attempted if you are logged in as root in another shell.

This will be skipped if "Y" isn't pressed within the next 15 seconds.
EOF
  read -N 1 -t 15 -p "Update sudoers file? [y/N] " update_sudoers; echo
    if [[ "$update_sudoers" =~ [Yy] ]]; then
        e_header "Updating sudoers..."
        visudo -cf "$sudoers_src" > /dev/null && {
        sudo cp "$sudoers_src" "$sudoers_dest" &&
        sudo chmod 0440 "$sudoers_dest"
    } >/dev/null 2>&1 &&
        echo "File $sudoers_dest updated" ||
        echo "Error updating $sudoers_dest file"
    else
        echo "Skipping."
    fi
fi

###############################################################################
# Update & Install APT packages
###############################################################################
e_header "Updating and installing APT packages..."
if ! skip; then
    source ~/.dotfiles/config/ubuntu/apt.sh
fi

###############################################################################
# Install Node.js and Npm
###############################################################################
# Note: APT packages are outdated on Ubuntu
e_header "Installing Node.js and Npm..."
if ! skip; then
    mkdir ~/local

    mkdir ~/node-latest-install
    cd ~/node-latest-install
    git clone git://github.com/joyent/node.git
    cd node
    ./configure --prefix=~/local
    make install

    mkdir ~/npm-latest-install
    cd ~/npm-latest-install
    git clone git://github.com/isaacs/npm.git
    cd npm
    make install
fi