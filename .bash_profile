###############################################################################
# Load dotfiles
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
#. ~/code/z/z.sh

###############################################################################
# Init RVM
###############################################################################
source ~/.rvm/scripts/rvm

###############################################################################
# Init VirtualEnvWrapper
###############################################################################
if [[ -r "${PYTHON_HOME}/virtualenvwrapper.sh" ]]; then
    source "${PYTHON_HOME}/virtualenvwrapper.sh"
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi

