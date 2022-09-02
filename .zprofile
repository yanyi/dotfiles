# Load Go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

# Homebrew
# M1 Mac will install at `/opt/homebrew`.
if [[ $(uname -m) == 'arm64' ]]; then
	eval $(/opt/homebrew/bin/brew shellenv)
else
	eval $(/usr/local/homebrew/bin/brew shellenv)
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Delta
# https://github.com/dandavison/delta#mouse-scrolling
export DELTA_PAGER="less -R"
