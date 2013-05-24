# This file is sourced at the end of a first-time dotfiles install

if [[ "$OSTYPE" =~ ^darwin ]]; then
cat <<EOF
----------------------------------------
Manual Installs
----------------------------------------
Applications / Plug-ins:

 * Adium SIPE plug-in
    http://cocoabrokemybrain.com/2013/01/16/fixing-microsoft-communicatorlync-support-on-adium-1-5-4-with-mac-os-10-8-mountain-lion/
 * Microsoft Remote Desktop for Mac
    http://www.microsoft.com/en-us/download/confirmation.aspx?id=18140
 * Parallels

Homebrew Packages / Casks:

 * VirtualBox
 * XTra Finder

----------------------------------------
SSH Keys (if this is a server)
----------------------------------------
 1. (main) scp ~/.ssh/id_rsa.pub $USER@$(wanip):~/.ssh/
 2. (here) cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
EOF
elif [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
cat <<EOF
----------------------------------------
SSH Keys (if this is a server)
----------------------------------------
 1. (main) scp ~/.ssh/id_rsa.pub $USER@$(wanip):~/.ssh/
 2. (here) cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
EOF
fi