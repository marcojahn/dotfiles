# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

export PATH="/usr/local/homebrew/bin:/usr/local/homebrew/sbin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,bash_prompt,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

## sdkman
export SDKMAN_DIR="$HOME/.sdkman"
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
if [ ! -z "$LOCATION" -a "$LOCATION" = "DB-Systel" ]; then
	. ~/_env/dbsystel
	# https://answers.atlassian.com/questions/14932/using-proxies-with-sourcetree
	# TODO copy .hgrc with proxy settings for sourcetree
	# TODO copy .gitconfig with proxy settings for sourcetree
	# TODO use base config files with string replacement

else
#OFF#	. ~/_env/no_proxy
	unset ALL_PROXY
	unset HTTP_PROXY
	unset HTTPS_PROXY
	unset PLATFORM
	# TODO restore initial .hgrc
	# TODO restore initial .gitconfig
fi

#OFF#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/mjahn/.sdkman"
[[ -s "/Users/mjahn/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mjahn/.sdkman/bin/sdkman-init.sh"

###-begin-ng-completion###
#

# ng command completion script
#   This command supports 3 cases.
#   1. (Default case) It prints a common completion initialisation for both Bash and Zsh.
#      It is the result of either calling "ng completion" or "ng completion -a".
#   2. Produce Bash-only completion: "ng completion -b" or "ng completion --bash".
#   3. Produce Zsh-only completion: "ng completion -z" or "ng completion --zsh".
#
# Usage: . <(ng completion --bash) # place it appropriately in .bashrc or
#        . <(ng completion --zsh) # find a spot for it in .zshrc
#
_ng_completion() {
  local cword pword opts

  COMPREPLY=()
  cword=${COMP_WORDS[COMP_CWORD]}
  pword=${COMP_WORDS[COMP_CWORD - 1]}

  case ${pword} in
    ng|help) opts="--version -v b build completion doc e e2e eject g generate get help l lint n new s serve server set t test v version xi18n" ;;
    b|build) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --environment --extract-css --extract-licenses --i18n-file --i18n-format --locale --missing-translation --named-chunks --output-hashing --output-path --poll --preserve-symlinks --progress --show-circular-dependencies --sourcemaps --stats-json --target --vendor-chunk --verbose --watch -a -aot -bh -buildOptimizer -cc -d -dop -e -ec -extractLicenses -i18nFile -i18nFormat -locale -missingTranslation -nc -oh -op -poll -pr -preserveSymlinks -scd -sm -statsJson -t -v -vc -w" ;;
    completion) opts="--all --bash --zsh -a -b -z" ;;
    doc) opts="--search -s" ;;
    e|e2e) opts="--aot --app --base-href --build-optimizer --common-chunk --config --delete-output-path --deploy-url --disable-host-check --element-explorer --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --missing-translation --named-chunks --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --serve --serve-path --show-circular-dependencies --sourcemaps --specs --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch --webdriver-update -H -a -aot -bh -buildOptimizer -c -cc -d -disableHostCheck -dop -e -ec -ee -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -missingTranslation -nc -o -oh -op -p -pc -poll -pr -preserveSymlinks -s -scd -servePath -sm -sp -ssl -sslCert -sslKey -t -v -vc -w -wu" ;;
    eject) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --environment --extract-css --extract-licenses --force --i18n-file --i18n-format --locale --missing-translation --named-chunks --output-hashing --output-path --poll --preserve-symlinks --progress --show-circular-dependencies --sourcemaps --target --vendor-chunk --verbose --watch -a -aot -bh -buildOptimizer -cc -d -dop -e -ec -extractLicenses -force -i18nFile -i18nFormat -locale -missingTranslation -nc -oh -op -poll -pr -preserveSymlinks -scd -sm -t -v -vc -w" ;;
    g|generate) opts="--app --collection --dry-run --force --lint-fix -a -c -d -f -lf" ;;
    get) opts="--global -global" ;;
    help) opts="--short -s" ;;
    l|lint) opts="--fix --force --format --type-check -fix -force -t -typeCheck" ;;
    n|new) opts="--collection --dry-run --link-cli --skip-commit --skip-git --skip-install --verbose -c -d -lc -sc -sg -si -v" ;;
    s|serve|server) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --disable-host-check --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --missing-translation --named-chunks --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --serve-path --show-circular-dependencies --sourcemaps --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch -H -a -aot -bh -buildOptimizer -cc -d -disableHostCheck -dop -e -ec -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -missingTranslation -nc -o -oh -op -p -pc -poll -pr -preserveSymlinks -scd -servePath -sm -ssl -sslCert -sslKey -t -v -vc -w" ;;
    set) opts="--global -g" ;;
    t|test) opts="--app --browsers --code-coverage --colors --config --environment --log-level --poll --port --progress --reporters --single-run --sourcemaps --watch -a -browsers -c -cc -colors -e -logLevel -poll -port -progress -reporters -sm -sr -w" ;;
    --version|-v|v|version) opts="--verbose -verbose" ;;
    xi18n) opts="--app --i18n-format --locale --out-file --output-path --progress --verbose -a -f -l -of -op -progress -verbose" ;;
    *) opts="" ;;
  esac

  COMPREPLY=( $(compgen -W '${opts}' -- $cword) )

  return 0
}

complete -o default -F _ng_completion ng
###-end-ng-completion###
