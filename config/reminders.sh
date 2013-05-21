# This file is sourced at the end of a first-time dotfiles install
cat <<EOF
OS X Manual Installs:
 *  Microsoft Remote Desktop for Mac
    http://www.microsoft.com/en-us/download/confirmation.aspx?id=18140

SSH Keys (if this is a server):
 1. (main) scp ~/.ssh/id_rsa.pub $USER@$(wanip):~/.ssh/
 2. (here) cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
EOF