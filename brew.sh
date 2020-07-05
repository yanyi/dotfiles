#!/usr/bin/env bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew-cask daily
brew cask install alfred
brew cask install avast-security
brew cask install docker
brew cask install dropbox
brew cask install firefox
brew cask install iterm2
brew cask install keepingyouawake
brew cask install rectangle
brew cask install sourcetree
brew cask install spotify
brew cask install telegram
brew cask install the-unarchiver
brew cask install visual-studio-code
brew cask install whatsapp

# brew-cask less often
brew cask install anki
brew cask install appcleaner
brew cask install calibre
brew cask install cryptomator
brew cask install diffmerge
brew cask install discord
brew cask install dnscrypt
brew cask install freefilesync
brew cask install google-chrome
brew cask install google-cloud-sdk
brew cask install handbrake
brew cask install iina
brew cask install imageoptim
brew cask install keepassxc
brew cask install mountain-duck
brew cask install mpv
brew cask install namechanger
brew cask install osxfuse
brew cask install signal
brew cask install skitch
brew cask install slack
brew cask install time-lapse-assembler
brew cask install transmission
brew cask install veracrypt
brew cask install virtualbox

# Install useful binaries
brew tap wagoodman/dive && brew install dive
brew install git
brew install git-crypt
brew install git-flow
brew install htop
brew install openssl
brew install ranger
brew install rbenv
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
