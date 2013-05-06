# dotfiles

https://github.com/mathiasbynens/dotfiles
https://github.com/paulirish/dotfiles
https://github.com/holman/dotfiles
https://github.com/cowboy/dotfiles

## Overview

#### OS X
* `setup.sh` - Install dependencies
* `.osx` - Configure OS X
* `.brew` - Install Homebrew formulae

#### Shell
* `.aliases`
* `.bash_profile`
* `.bash_prompt`
* `.bashrc`
* `.exports`
* `.functions`

#### Bash
* `.inputrc` - Bash readline config

#### Git
* `.gitattributes`
* `.gitconfig`
* `.gitignore`
* `.gitignore_global`

#### Tools
* `.ackrc`

## Start Fresh

### Homebrew

http://mxcl.github.io/homebrew/

https://github.com/phinze/homebrew-cask

#### Installation

```bash
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
```

```bash
brew doctor
```

```bash
brew update
```

If the “brew update” command produces an error, make sure /usr/local is owned by you and not by root:
```bash
sudo chown $USER /usr/local
brew update
```

Install Homebrew's bash completion script:
```bash
ln -s "/usr/local/Library/Contributions/brew_bash_completion.sh" "/usr/local/etc/bash_completion.d"
```

#### Homebrew and Python

https://github.com/mxcl/homebrew/wiki/Homebrew-and-Python
https://github.com/mxcl/homebrew/wiki/Gems%2C-Eggs-and-Perl-Modules

https://gist.github.com/pithyless/1208841
http://hackercodex.com/guide/python-virtualenv-on-mac-osx-mountain-lion-10.8/

__Important__

When you brew install formulae that provide Python bindings, **you should NOT be in an active virtual environment**.
Activate the virtualenv after you have brewed or, alternatively, brew in a fresh Terminal window.

```bash
brew install readline sqlite gdbm
brew install python --universal --framework
python --version
```

  * Comes with ```pip``` (and distribute)
  * No need to set the PYTHONPATH for Homebrew bindings

Distribute can be updated via Pip, without having to re-brew Python:
```bash
pip install --upgrade distribute
```

Similarly, Pip can be used to upgrade itself via:
```bash
pip install --upgrade pip
```