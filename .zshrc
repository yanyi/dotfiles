export ZSH=$HOME/.oh-my-zsh
# List all files in colour
export CLICOLOR=1

ZSH_THEME="oxide"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

#######################
# Aliases / Functions
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

# List tree structure, sorted by directories first
# brew install tree
alias tree="tree --dirsfirst"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Docker
alias docker-remove='docker rm $(docker ps -qa --no-trunc)'

# Generate random string
random()
{
  cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w ${1:-16} | head -n 1
}

# Generate random numbers
random_number()
{
  cat /dev/urandom | env LC_CTYPE=C tr -dc '0-9' | fold -w ${1:-10} | head -n 1
}

# Generate random file at path (per megabyte)
random_file_m()
{
  dd if=/dev/urandom of=RANDOM-GEN.txt bs=1m count=${1:-10}
}

# Generate random file at path (per gigabyte)
random_file_g()
{
  dd if=/dev/urandom of=RANDOM-GEN.txt bs=1g count=${1:-1}
}

# Added by Krypton
export GPG_TTY=$(tty)
