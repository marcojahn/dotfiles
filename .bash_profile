# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

export PATH="/usr/local/homebrew/bin:/usr/local/homebrew/sbin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

## sdkman
export SDKMAN_DIR="$HOME/.sdkman"
#source "/Users/mjahn/.sdkman/bin/sdkman-init.sh"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh" # This loads sdkman

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
#OFF#scomplete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
#OFF#scomplete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

#proxy settings
# http://arstechnica.com/civis/viewtopic.php?f=19&t=147601
#OFF#export LOCATION=$(/usr/sbin/scselect 2>&1 | perl -ne 'if (m/^\s+\*\s+(\S+)\s+\((.+)\)$/) { print "$2\n"; }')
#OFF#if [ ! -z "$LOCATION" -a "$LOCATION" = "Merck R&D" ]; then
#OFF#	. ~/_env/proxy_merck
	# https://answers.atlassian.com/questions/14932/using-proxies-with-sourcetree
	# TODO copy .hgrc with proxy settings for sourcetree
	# TODO copy .gitconfig with proxy settings for sourcetree
	# TODO use base config files with string replacement
#OFF#else
#OFF#	. ~/_env/no_proxy
	# TODO restore initial .hgrc
	# TODO restore initial .gitconfig
#OFF#fi

#OFF#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
