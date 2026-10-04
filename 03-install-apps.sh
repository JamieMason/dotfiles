#!/usr/bin/env bash

# Install all formulae and casks from the Brewfile
brew update
brew bundle --file="$(dirname "$0")/Brewfile"
brew upgrade
brew cleanup
