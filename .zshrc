export LANG=en_US.UTF-8
export TERM="xterm-256color"

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="geometry/geometry"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Load nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load rvm (Ruby Version Manager)
export PATH="$HOME/.rvm/bin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Load Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Load Go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

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

#####################
# geometry Settings #
#####################

GEOMETRY_COLOR_EXIT_VALUE="magenta"
GEOMETRY_COLOR_PROMPT="white"
GEOMETRY_COLOR_ROOT="red"
GEOMETRY_COLOR_DIR="blue"
GEOMETRY_PROMPT_SUFFIX="\n $"
GEOMETRY_SYMBOL_SPACER=" "
GEOMETRY_DIR_SPACER=" "
GEOMETRY_PLUGIN_SEPARATOR=" "
