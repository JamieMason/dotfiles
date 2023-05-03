#!/usr/bin/env bash

# install https://github.com/koekeishiya/skhd
brew install koekeishiya/formulae/skhd
cp ./home/skhdrc ~/.skhdrc
skhd --install-service
skhd --start-service
