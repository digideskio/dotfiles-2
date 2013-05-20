# Source files in ~/.dotfiles/source/
function src() {
    for file in ~/.dotfiles/source/.{path,colors,prompt,bash_prompt,exports,aliases,functions}; do
        [ -r "$file" ] && source "$file"
    done
}

# Run dotfiles script, then source
function dotfiles() {
    ~/.dotfiles/bin/dotfiles "$@" && src
}

# Run dotfiles script, then source
function sync() {
    ~/.dotfiles/bin/sync "$@" && src
}

###############################################################################
# Source dotfiles
###############################################################################
src

###############################################################################
# Bash Options
###############################################################################
# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs 755 drwxr-xr-x (777 minus 022)
umask 022

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Allow use to re-edit a faild history substitution
shopt -s histreedit

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash  4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done

# Don't check mail when opening terminal
unset MAILCHECK

###############################################################################
# Completions
###############################################################################
# SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# `defaults read|write NSGlobalDomain`
complete -W "NSGlobalDomain" defaults

# Homebrew
if [[ "$(type -P brew)" ]]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

# Grunt
if [[ "$(type -P grunt)" ]]; then
    eval "$(grunt --completion=bash)"
fi

# z
#complete -C 'z --complete "$COMP_LINE"' z

###############################################################################
# Init z
###############################################################################
_Z_NO_PROMPT_COMMAND=1
. ~/.dotfiles/lib/z/z.sh

###############################################################################
# Init Ruby
###############################################################################
if [[ "$(type -P rbenv)" && ! "$(type -t _rbenv)" ]]; then
    eval "$(rbenv init -)"
fi

###############################################################################
# Init Nave
###############################################################################
if [[ "$(type -P nave)" ]]; then
    nave_default="$(nave ls | awk '/^default/ {print $2}')"
    if [[ "$nave_default" && "$(node --version 2>/dev/null)" != "v$nave_default" ]]; then
        node_path=~/.nave/installed/$nave_default/bin
        if [[ -d "$node_path" ]]; then
            PATH=$node_path:$(path_remove ~/.nave/installed/*/bin)
        fi
    fi
fi

###############################################################################
# Init VirtualEnvWrapper
###############################################################################
if [[ -r "/usr/local/share/python/virtualenvwrapper.sh" ]]; then
    source "/usr/local/share/python/virtualenvwrapper.sh"
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi

