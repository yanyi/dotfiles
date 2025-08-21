#!/usr/bin/env bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew-cask daily
brew install --cask alfred
brew install --cask docker
brew install --cask dropbox
brew install --cask firefox
brew install --cask iterm2
brew install --cask jordanbaird-ice
brew install --cask keepingyouawake
brew install --cask maccy
brew install --cask obsidian
brew install --cask rectangle
brew install --cask spotify
brew install --cask telegram
brew install --cask the-unarchiver
brew install --cask visual-studio-code
brew install --cask whatsapp

# brew-cask less often
brew install --cask appcleaner
brew install --cask cryptomator
brew install --cask discord
brew install --cask freefilesync
brew install --cask google-chrome
brew install --cask handbrake
brew install --cask iina
brew install --cask imageoptim
brew install --cask keepassxc
brew install --cask libreoffice
brew install --cask medis
brew install --cask namechanger
brew install --cask signal
brew install --cask transmission

# Install useful binaries
brew install autojump
brew install fzf
brew install git
brew install git-crypt
brew install git-delta
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

# Remove outdated versions from the cellar
brew cleanup
