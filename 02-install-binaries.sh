#!/usr/bin/env bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install binaries
brew install act
brew install ast-grep
brew install cargo-dist
brew install docker
brew install duti
brew install fd
brew install fnm
brew install fonttools
brew install gh
brew install git
brew install graphviz
brew install hub
brew install imagemagick
brew install jq
brew install neovim
brew install ripgrep
brew install tree
brew install vim
brew install wget

# Remove outdated versions from the cellar.
brew cleanup

# https://stackoverflow.com/q/71591971/745158#comment127364294_71621142
ln -s /usr/local/bin/python3 /usr/local/bin/python
