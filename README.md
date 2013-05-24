# dotfiles

https://github.com/cowboy/dotfiles

https://github.com/mathiasbynens/dotfiles

https://github.com/paulirish/dotfiles

https://github.com/holman/dotfiles

https://github.com/fbeeper/fBootstrap/

## Quick Start

Download the dotfiles and run the installer:

```bash
bash -c "$(curl -fsSL https://raw.github.com/jcrafford/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

## Overview

#### config

_dotfiles_

* `config/utils.sh` - Configuration utilities
* `config/devel-setup.sh` - Install and configure development software
* `config/reminders.sh` - Reminders shown after dotfiles installation

_OS X_

* `config/osx/osx.sh` - Install and configure OS X software
* `config/osx/osx_defaults.sh` - Configure OS X defaults
* `config/osx/brew.sh` - Install Homebrew formulae and Casks

_Ubuntu_

* `config/ubuntu/ubuntu.sh` - Install and configure Ubuntu software
* `config/ubuntu/apt.sh` - Install apt packages

#### source

Sourced on shell startup sequentially as defined in `.bashrc`:

1. `source/.path` - Determine $PATH environment var
2. `source/.colors` - Shell color helper functions
3. `source/.prompt` - Shell prompt helper functions
4. `source/.bash_prompt` - Custom shell prompt (VCS and virtualenv aware)
5. `source/.exports` - Environment variables for tools and configuration
6. `source/.aliases` - Shell aliases and utilties
7. `source/.functions` - Shell functions for productivity and development

#### link

All files in the `link` directory are symlinked into the home directory.
Backups are created if necessary.

* `link/.bash_profile`
* `link/.bashrc`
* `link/.hushlogin` - Silence terminal welcome text
* `link/.inputrc` - Bash readline config
<div/>
* `link/.ackrc`
* `link/.irbrc`
* `link/.gemrc`
* `link/.screenrc`
* `link/.wgetrc`
<div/>
* `link/.gitattributes`
* `link/.gitignore_global`

#### copy

All files in the `copy` directory are copied into the home directory.
Backups are created if necessary.

* `copy/.gitconfig`

#### bin

All files in the `bin` directory are considered executable binaries.
The `dotfiles` installer will chmod +x this directory.

* `bin/dotfiles` - Install git, clone repo into ~/.dotfiles, perform setup
* `bin/sync` - Pull files from repo, copy/symlink into home, backup as necassary
<div/>
* `bin/pid`
* `bin/scan`
* `bin/serve`
* `bin/ssid`

__lib__

* `lib/z` - Jump to most frequent directories

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
