#!/usr/bin/env bash

# Ensure .config exists
mkdir -p ~/.config

# Remove any modifications to Neovim
rm -rf ~/.config/nvim

# Replace Neovim setup
cp -r ./nvim ~/.config/nvim

# Replace all dotfiles in $HOME
cp -R ./home/ ~
