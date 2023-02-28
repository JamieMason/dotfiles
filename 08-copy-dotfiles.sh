#!/usr/bin/env bash

# Ensure .config exists
mkdir -p ~/.config

# Replace Neovim setup
rm -rf ~/.config/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
cp -r ./nvim/lua/custom ~/.config/nvim/lua

# Replace all dotfiles in $HOME
cp -R ./home/ ~
