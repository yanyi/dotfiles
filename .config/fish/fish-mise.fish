# Activate mise so project-level mise.toml files are applied in Fish.
if type -q mise
    mise activate fish | source
end

# Load autojump for Fish if available
if test -f /usr/share/autojump/autojump.fish
    source /usr/share/autojump/autojump.fish
end
