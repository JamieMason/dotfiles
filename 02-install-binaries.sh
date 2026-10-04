#!/usr/bin/env bash

# Install Homebrew (if missing)
if ! command -v brew >/dev/null 2>&1 && [ ! -x /opt/homebrew/bin/brew ] && [ ! -x /usr/local/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Put brew on PATH (Apple Silicon: /opt/homebrew, Intel: /usr/local)
eval "$("$(test -x /opt/homebrew/bin/brew && echo /opt/homebrew/bin/brew || echo /usr/local/bin/brew)" shellenv)"

# oh my zsh (if missing; keep our .zshrc, don't switch shell or launch zsh)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# zsh-syntax-highlighting plugin (clone, or update if present)
plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ -d "$plugin_dir/.git" ]; then
  git -C "$plugin_dir" pull --ff-only
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugin_dir"
fi
