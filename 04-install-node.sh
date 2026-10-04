#!/usr/bin/env bash

# Ensure brew is on PATH (this script runs in its own shell)
eval "$("$(test -x /opt/homebrew/bin/brew && echo /opt/homebrew/bin/brew || echo /usr/local/bin/brew)" shellenv)"

# fnm is installed via the Brewfile
# Instantiate FNM
eval "$(fnm env --use-on-cd)"

# install latest LTS node
fnm install --lts

# use latest LTS node
fnm use lts-latest

# Set this Node version as the default
fnm default "$(node -v)"
