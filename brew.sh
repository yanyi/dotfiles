#!/usr/bin/env bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# brew-cask daily
brew cask install alfred
brew cask install caffeine
brew cask install dropbox
brew cask install google-chrome
brew cask install vlc

# brew-cask less often
brew cask install appcleaner
brew cask install firefox
brew cask install handbrake
brew cask install slack

# Install useful binaries
brew install curl
brew install git
brew install git-flow

# Remove outdated versions from the cellar
brew cleanup
