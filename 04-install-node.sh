#!/usr/bin/env bash

# fnm is installed via the Brewfile
# Instantiate FNM
eval "$(fnm env --use-on-cd)"

# install latest LTS node
fnm install --lts

# use latest LTS node
fnm use lts-latest

# Set this Node version as the default
fnm default "$(node -v)"
