#!/usr/bin/env bash

# Ensure .config exists
mkdir -p ~/.config ~/.config/zed

# Set up Neovim (only clone NvChad if missing)
if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi
cp -r ./nvim/lua/custom ~/.config/nvim/lua

# Replace all dotfiles in $HOME
cp -R ./home/ ~

# Copy Zed settings
cp ./zed/settings.json ~/.config/zed/settings.json

# Copy CLI git helpers (bin/ + lib/ are the deployable runtime; gb/gl/gs/gbr
# in bin/ resolve lib/ as a sibling, which the global justfile invokes)
rm -rf ~/cli
mkdir -p ~/cli
cp -R ./cli/bin ./cli/lib ~/cli/
