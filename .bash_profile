# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
#OFF#shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
#OFF#sshopt -s histappend

# Autocorrect typos in path names when using `cd`
#OFF#sshopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
#OFF#sfor option in autocd globstar; do
#OFF#s	shopt -s "$option" 2> /dev/null
#OFF#sdone

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
#OFF#s[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
#OFF#scomplete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
#OFF#scomplete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
#OFF#s[ -f /etc/bash_completion ] && source /etc/bash_completion