# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Load nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load rvm (Ruby Version Manager)
export PATH="$HOME/.rvm/bin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


