#!/usr/bin/env bash

export PATH="$HOME/.cargo/bin:$PATH"
# Ensure brew is on PATH (this script runs in its own shell)
eval "$("$(test -x /opt/homebrew/bin/brew && echo /opt/homebrew/bin/brew || echo /usr/local/bin/brew)" shellenv)"

npm install -g npm

npm install -g @antfu/ni
npm install -g @biomejs/biome
npm install -g http-server
npm install -g npm-check-updates
npm install -g pnpm
npm install -g prettier
npm install -g svgo
npm install -g syncpack@alpha
npm install -g tsx
