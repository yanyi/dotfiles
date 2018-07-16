# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/yanyi/.oh-my-zsh

# Set name of the theme to load.
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

####################
# Added Personally #
####################

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

# Change Working Directory to Development
# cd ~/Documents/Development

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

#########################
# Powerlevel9k Settings #
#########################

POWERLEVEL9K_COLOR_SCHEME='light'

# Left prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time dir vcs ssh)

# Right prompt
# POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rvm root_indicator docker_machine)

# Command prompt below segments/prompt
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "

# Add new line after prompt
# POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# time
POWERLEVEL9K_TIME_FOREGROUND='white'
POWERLEVEL9K_TIME_BACKGROUND='red'

# dir
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_DIR_SHOW_WRITABLE=true

# status
POWERLEVEL9K_STATUS_OK=true
POWERLEVEL9K_STATUS_CROSS=true
