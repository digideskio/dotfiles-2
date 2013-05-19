###############################################################################
# Source base scripts
###############################################################################
for file in ~/bin/{colors,prompt}.sh; do
    [ -r "$file" ] && source "$file"
done
unset file

###############################################################################
# Source dotfiles
###############################################################################
for file in ~/.{bash_prompt,exports,aliases,functions,path}; do
    [ -r "$file" ] && source "$file"
done
unset file

###############################################################################
# Bash Options
###############################################################################
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
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
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Autocomplete Grunt commands
which grunt > /dev/null && eval "$(grunt --completion=bash)"

###############################################################################
# Init z
###############################################################################
#. ~/Tools/z/z.sh

###############################################################################
# Init Ruby
###############################################################################
PATH=$(path_remove ~/.dotfiles/lib/rbenv/bin):~/.dotfiles/lib/rbenv/bin
PATH=$(path_remove ~/.dotfiles/lib/ruby-build/bin):~/.dotfiles/lib/ruby-build/bin

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

