#!/usr/bin/env bash

# Install Node Version Manager
brew install fnm

# Instantiate FNM
eval "$(fnm env --use-on-cd)"

# install latest LTS node
fnm install --lts

# Set this Node version as the default
fnm default "$(node -v)"
