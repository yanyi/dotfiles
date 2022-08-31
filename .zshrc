export ZSH=$HOME/.oh-my-zsh
# List all files in colour
export CLICOLOR=1
export LC_ALL=en_US.UTF-8

fpath=($HOME/completion $fpath)
autoload -Uz compinit && compinit -I
ZSH_THEME="oxide"
plugins=(git zsh-autosuggestions history-search-multi-word)
source $ZSH/oh-my-zsh.sh

#######################
# Aliases / Functions #
#######################

# Shortcuts
alias dv="cd ~/Documents/Development"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias ls="ls -aGp"

# Restart OS X Finder, Dock or Menubar
alias killFinder="killall Finder"
alias killDock="killall Dock"
alias killMenu="killall SystemUIServer"

# Show/hide hidden files in Finder
alias showFiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hideFiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hideDesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showDesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# git alias replacement
alias gd="git d"
alias gl="git l"
alias gfu="git fixup"
alias gfr="git frm"

# List tree structure, sorted by directories first
# brew install tree
alias tree="tree --dirsfirst"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Generate a temporary directory in /tmp
# From `jtm` on Lobsters https://lobste.rs/s/zpw6py/how_do_you_organize_your_home_directory#c_rre2uy
t()
{
  cd $(mktemp -d /tmp/$1.XXXX)
}
