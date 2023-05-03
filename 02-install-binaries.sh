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
brew install duti
brew install fd
brew install git
brew install hub
brew install neovim
brew install ripgrep
brew install tree
brew install vim
brew install wget

# Remove outdated versions from the cellar.
brew cleanup

