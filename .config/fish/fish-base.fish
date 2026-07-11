# Base PATH configuration
fish_add_path /usr/bin /usr/sbin /bin /sbin
fish_add_path $HOME/.local/bin

# Development environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER "batcat --paging=always"

# Delta configuration for git
export DELTA_PAGER="less -R"
export LESS=
