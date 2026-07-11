# Main Fish configuration - sources all components
source ~/.config/fish/fish-base.fish
source ~/.config/fish/fish-aliases.fish
source ~/.config/fish/fish-git.fish
source ~/.config/fish/fish-asdf.fish
export PATH="$(go env GOBIN):$PATH"
export PATH="/home/dev/.cache/rebar3/bin:$PATH"

# SSH Agent forwarding from macOS host (Strategy 5: Fixed Socket Path)
if test -S /ssh-agent
    # Fix permissions on every shell start (socket may not exist at entrypoint time)
    sudo chmod 666 /ssh-agent 2>/dev/null
    set -gx SSH_AUTH_SOCK /ssh-agent
end

# pnpm
set -gx PNPM_HOME "/home/dev/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
