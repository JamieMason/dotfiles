# Jamie’s dotfiles

> Review the code and remove what you don’t need before running anything.

## What it does

1. `01-configure-mac.sh`: macOS `defaults` tweaks.
2. `02-install-binaries.sh`: Homebrew, oh-my-zsh, zsh-syntax-highlighting.
3. `03-install-apps.sh`: `brew bundle` from [`Brewfile`](Brewfile) (CLI tools
   and apps, incl. Zed, iTerm2, Alfred, Rectangle, bat, eza, delta).
4. `04-install-node.sh`: Node LTS via `fnm`.
5. `05-install-rust.sh`: Rust via `rustup`.
6. `06-install-npm-binaries.sh`: global npm tools (biome, pnpm, tsx, etc.).
7. `07-set-default-apps.sh`: open text/code file types in Zed.
8. `08-copy-dotfiles.sh`: NvChad (if missing), `home/*`, Zed settings, `cli/`.

## Usage

```bash
git clone https://github.com/JamieMason/dotfiles.git ~/Dev/dotfiles
cd ~/Dev/dotfiles
# edit USER_NAME / USER_EMAIL in home/.extra
./bootstrap.sh
```

Dotfiles are copied, not symlinked: re-run `08-copy-dotfiles.sh` after edits.
