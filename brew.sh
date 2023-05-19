#!/usr/bin/env bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew-cask daily
brew install --cask alfred
brew install --cask docker
brew install --cask dozer
brew install --cask dropbox
brew install --cask firefox
brew install --cask iterm2
brew install --cask keepingyouawake
brew install --cask rectangle
brew install --cask sourcetree
brew install --cask spotify
brew install --cask telegram
brew install --cask the-unarchiver
brew install --cask visual-studio-code
brew install --cask whatsapp

# brew-cask less often
brew install --cask aerial
brew install --cask appcleaner
brew install --cask cryptomator
brew install --cask discord
brew install --cask dnscrypt
brew install --cask freefilesync
brew install --cask google-chrome
brew install --cask google-cloud-sdk
brew install --cask handbrake
brew install --cask iina
brew install --cask imageoptim
brew install --cask keepassxc
brew install --cask libreoffice
brew install --cask medis
brew install --cask namechanger
brew install --cask signal
brew install --cask slack
brew install --cask time-lapse-assembler
brew install --cask transmission
brew install --cask veracrypt
brew install --cask virtualbox

# Install useful binaries
brew install autojump
brew tap wagoodman/dive && brew install dive
brew install fzf
brew install git
brew install git-crypt
brew install git-delta
brew install git-flow
brew install htop
brew install just
brew install openssl
brew install ranger
brew install rbenv
brew install rclone
brew install ripgrep
brew install tree
brew install vim
brew install watch
brew install wget
brew install yarn
brew install youtube-dl

# brew taps
brew tap buo/cask-upgrade # https://github.com/buo/homebrew-cask-upgrade
brew tap homebrew/cask-fonts

# Remove outdated versions from the cellar
brew cleanup
