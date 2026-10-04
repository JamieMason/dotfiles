#!/usr/bin/env bash

# Ensure brew is on PATH (this script runs in its own shell)
eval "$("$(test -x /opt/homebrew/bin/brew && echo /opt/homebrew/bin/brew || echo /usr/local/bin/brew)" shellenv)"

# Install all formulae and casks from the Brewfile
brew update
brew bundle --file="$(dirname "$0")/Brewfile"
brew upgrade
brew cleanup
