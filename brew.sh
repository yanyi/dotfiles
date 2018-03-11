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
brew cask install firefox
brew cask install vlc

# brew-cask less often
brew cask install appcleaner
brew cask install google-chrome
brew cask install handbrake

# Install useful binaries
brew install ffmpeg
brew install git
brew install git-flow
brew install openssl
brew install wget
brew install zsh

# Remove outdated versions from the cellar
brew cleanup
