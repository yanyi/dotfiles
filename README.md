# dotfiles
These are my dotfiles. Most of them are inspired by [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)

## Installation

### New Mac

Install [Homebrew](http://brew.sh/):

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install git:

```sh
brew install git
```

Clone the repository to your Mac:

```sh
git clone https://github.com/yanyi/dotfiles.git
```

`cd` to the cloned `dotfiles` repository and:

```sh
source bootstrap.sh
```

Run the following to set up the Mac OS X defaults:

```sh
./.osx
```

Run the following to install some Homebrew formulae:

```sh
./brew.sh
```

### Updating Existing Mac

Run:

```sh
source bootstrap.sh
```

## Symlink
```
$ ln -s ~/Documents/Development/dotfiles ~/dotfiles
```
