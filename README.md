# dotfiles
These are my dotfiles/config files. Most of them are inspired by [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)

## Installation

### New Mac

Install [Homebrew](http://brew.sh/):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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

Run the following to set up the macOS defaults:

```sh
./.macos
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
