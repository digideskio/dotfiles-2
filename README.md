# dotfiles

https://github.com/cowboy/dotfiles

https://github.com/mathiasbynens/dotfiles

https://github.com/paulirish/dotfiles

https://github.com/holman/dotfiles

https://github.com/fbeeper/fBootstrap/

## Overview

#### Config

* `config/devel-setup.sh` - Install and configure development software
* `config/reminders.sh` - Reminders shown after dotfiles installation
* `config/utils.sh` - Configuration utilities

_OS X_

* `config/osx/osx.sh` - Install and configure OS X software
* `config/osx/osx_defaults.sh` - Configure OS X defaults
* `config/osx/brew.sh` - Install Homebrew formulae and Casks

_Ubuntu_

* `config/ubuntu/ubuntu.sh` - Install and configure Ubuntu software
* `config/ubuntu/apt.sh` - Install apt packages

#### Shell

1. `source/.path`
2. `source/.colors`
3. `source/.prompt`
4. `source/.bash_prompt`
5. `source/.exports`
6. `source/.aliases`
7. `source/.functions`

* `link/.bash_profile`
* `link/.bashrc`
* `link/.hushlogin` - Silence terminal welcome text
* `link/.inputrc` - Bash readline config

#### Git

* `copy/.gitconfig`
* `link/.gitattributes`
* `link/.gitignore_global`

#### Tools

* `link/.ackrc`
* `link/.irbrc`
* `link/.gemrc`
* `link/.screenrc`
* `link/.wgetrc`

## Installation

### Fresh Start

```bash
bash -c "$(curl -fsSL https://raw.github.com/jcrafford/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

### Syncing dotfiles

After git has been installed you can keep the local dotfiles synced to the repository as follows:

```bash
sync
```

## Notes

#### Homebrew and Python

  * Comes with ```pip``` (and distribute)
  * No need to set the PYTHONPATH for Homebrew bindings

https://github.com/mxcl/homebrew/wiki/Homebrew-and-Python

https://github.com/mxcl/homebrew/wiki/Gems%2C-Eggs-and-Perl-Modules

https://gist.github.com/pithyless/1208841

http://hackercodex.com/guide/python-virtualenv-on-mac-osx-mountain-lion-10.8/

__Important__

When you brew install formulae that provide Python bindings, **you should NOT be in an active virtual environment**.
Activate the virtualenv after you have brewed or, alternatively, brew in a fresh Terminal window.
