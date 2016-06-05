#!/usr/bin/env bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# brew-cask
brew cask install alfred
brew cask install appcleaner
brew cask install caffeine
brew cask install dropbox
brew cask install google-chrome
brew cask install vlc

# Install useful binaries
brew install git

# Remove outdated versions from the cellar
brew cleanup
