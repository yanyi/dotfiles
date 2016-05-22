[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[ -r $HOME/.bashrc ] && source $HOME/.bashrc # Load the .bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"