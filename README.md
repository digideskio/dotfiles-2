# dotfiles

https://github.com/cowboy/dotfiles

https://github.com/mathiasbynens/dotfiles

https://github.com/paulirish/dotfiles

https://github.com/holman/dotfiles

https://github.com/fbeeper/fBootstrap/

## Quick Start

1.  Clone this repository
2.  Configure which packages and applications get installed by modifying `osx/brew.sh` or `unbuntu/apt.sh`
3.  Paths and environment variables are maintained in `source/.path` and `source/.exports`
4.  Remember to replace instances of `jcrafford` and `justin` with your credentials
5.  Download the dotfiles and run the installer:

```bash
bash -c "$(curl -fsSL https://raw.github.com/jcrafford/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

The installer script will perform the following actions:

1.  Install Git (via Homebrew on OS X or apt-get on Ubuntu)
2.  Clone the `dotfiles` repository into `~/.dotfiles`
3.  Run the OS-specific software installs in `config/osx` or `config/ubuntu`
4.  Run the development software setup in `config/devel-setup.sh`
5.  Source the linked `.bashrc` script in the home directory
6.  Display reminders and further configuration instructions

Portions of the installation can be skipped by pressing `x`, but this should be avoided during a clean install.
Be aware that some steps require manual confirmation.

## Overview

#### config

_dotfiles_

* `utils.sh` - Configuration utilities
* `devel-setup.sh` - Install and configure development software
* `reminders.sh` - Reminders shown after dotfiles installation

_OS X_

* `osx/osx.sh` - Install and configure OS X software
* `osx/osx_defaults.sh` - Configure OS X defaults
* `osx/brew.sh` - Install Homebrew formulae and Casks

_Ubuntu_

* `ubuntu/ubuntu.sh` - Install and configure Ubuntu software
* `ubuntu/apt.sh` - Install apt packages

#### source

Sourced on shell startup sequentially as defined in `.bashrc`:

1. `.path` - Determine $PATH environment var
2. `.colors` - Shell color helper functions
3. `.prompt` - Shell prompt helper functions
4. `.bash_prompt` - Custom shell prompt (VCS and virtualenv aware)
5. `.exports` - Environment variables for tools and configuration
6. `.aliases` - Shell aliases and utilties
7. `.functions` - Shell functions for productivity and development

#### link

All files in the `link` directory are symlinked into the home directory.
Backups are created if necessary.

* `.bash_profile`
* `.bashrc`
* `.hushlogin` - Silence terminal welcome text
* `.inputrc` - Bash readline config
<div/>
* `.ackrc`
* `.irbrc`
* `.gemrc`
* `.screenrc`
* `.wgetrc`
<div/>
* `.gitattributes`
* `.gitignore_global`

#### copy

All files in the `copy` directory are copied into the home directory.
Backups are created if necessary.

* `.gitconfig`
* `.pip_default_requirements`

#### bin

All files in the `bin` directory are considered executable binaries.
The `dotfiles` installer will chmod +x this directory.

* `dotfiles` - Install git, clone repo into ~/.dotfiles, perform setup
* `sync` - Pull files from repo, copy/symlink into home, backup as necassary
<div/>
* `pid`
* `scan`
* `serve`
* `ssid`

#### lib

* `z` - Jump to most frequent directories

### Notes

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
