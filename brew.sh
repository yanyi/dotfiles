#!/usr/bin/env bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# brew-cask daily
brew cask install alfred
brew cask install avast-security
brew cask install caffeine
brew cask install dropbox
brew cask install firefox
brew cask install iterm2
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
brew cask install docker
brew cask install freefilesync
brew cask install google-chrome
brew cask install handbrake
brew cask install iina
brew cask install imageoptim
brew cask install jadengeller-helium
brew cask install keybase
brew cask install keepassxc
brew cask install launchcontrol
brew cask install mountain-duck
brew cask install mpv
brew cask install namechanger
brew cask install osxfuse
brew cask install postman
brew cask install signal
brew cask install skitch
brew cask install slack
brew cask install time-lapse-assembler
brew cask install transmission
brew cask install veracrypt
brew cask install virtualbox
brew cask install waterfox

# Install useful binaries
brew install ffmpeg
brew install git
brew install git-crypt
brew install git-flow
brew install openssl
brew install tree
brew install wget
brew install youtube-dl
brew install zsh

# brew taps
## https://github.com/buo/homebrew-cask-upgrade
brew tap buo/cask-upgrade

# Remove outdated versions from the cellar
brew cleanup
