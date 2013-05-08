# dotfiles

https://github.com/mathiasbynens/dotfiles

https://github.com/paulirish/dotfiles

https://github.com/holman/dotfiles

https://github.com/cowboy/dotfiles

https://github.com/fbeeper/fBootstrap/

## Overview

#### Config
* `sync.sh` - Update dotfiles from repository
* `config/setup.sh` - Install dependencies
* `config/brew.sh` - Install Homebrew formulae and Casks
* `config/osx.sh` - Configure OS X

#### Shell
* `.aliases`
* `.bash_profile`
* `.bash_prompt`
* `.bashrc`
* `.exports`
* `.functions`

#### Bash
* `.hushlogin` - Silence terminal welcome text
* `.inputrc` - Bash readline config

#### Git
* `.gitattributes`
* `.gitconfig`
* `.gitignore_global`

#### Tools
* `.ackrc`
* `.screenrc`
* `.wgetrc`

## Installation

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
