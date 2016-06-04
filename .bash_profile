[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[ -r $HOME/.bashrc ] && source $HOME/.bashrc # Load the .bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Show/Hide Hidden Files Aliases
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'