# dotfiles

https://github.com/mathiasbynens/dotfiles

https://github.com/paulirish/dotfiles

https://github.com/holman/dotfiles

https://github.com/cowboy/dotfiles

https://github.com/fbeeper/fBootstrap/

## Overview

#### Config
* `sync.sh` - Update dotfiles from repository
* `setup.sh` - Install dependencies
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

### Fresh Start

1. Download dotfiles

```bash
cd
mkdir .dotfiles 2> /dev/null
curl -#L https://github.com/jcrafford/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md} -C .dotfiles
```

2. Modify files to make customizations (ie. replacing occurrences of `jcrafford`)

3. Run the setup script to begin software installion and configuration

```bash
cd ~/.dotfiles; chmod +x setup.sh
. setup.sh
```

### Syncing dotfiles

After git has been installed you can keep the local dotfiles synced to the repository as follows:

1. Delete existing .dotfiles directory, for simplicty

```bash
rm -rdf ~/.dotfiles
```

2. Clone the repository

```bash
git clone https://github.com/jcrafford/dotfiles.git .dotfiles
```

3. Run the sync script. It will prompt you before overwriting the dotfiles in your home directory

```bash
cd ~/.dotfiles; chmod +x sync.sh
. sync.sh
```

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
