#!/usr/bin/env bash

# install https://github.com/koekeishiya/skhd
brew install koekeishiya/formulae/skhd
cp ./home/skhdrc ~/.skhdrc
mkdir -p ~/Library/LaunchAgents
skhd --install-service
skhd --start-service
