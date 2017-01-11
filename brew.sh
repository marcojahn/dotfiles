#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/homebrew/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/homebrew/bin/bash' /etc/shells; then
  echo '/usr/local/homebrew/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/homebrew/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php56 --with-gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.

# Install other useful binaries.
brew install ack
brew install caddy
brew install cloc
brew install dark-mode
#brew install exiv2
brew install git
brew install git-flow-avh
brew install git-flow-clone
brew install git-lfs
brew install ffmpeg
brew install htop
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install peco
brew install pigz
brew install pv
brew install rbenv
brew install rename
brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install testssl
brew install tree
brew install vbindiff
brew install webkit2png
brew install youtube-dl
brew install virtualhost.sh
brew install zopfli

# Remove outdated versions from the cellar.
brew cleanup