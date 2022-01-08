# Jamie’s dotfiles

![Screenshot of my shell prompt](https://i.imgur.com/ItNUSFe.png)

> **Warning:** If you want to give these dotfiles a try, you should first fork
> this repository, review the code, and remove things you don’t want or need.
> Don’t blindly use my settings unless you know what that entails. Use at your
> own risk!

These dotfiles will:

- Set some sensible default settings for a new Mac.
- Install [`brew`](http://brew.sh/) and some useful formulae including
  [`git`](https://git-scm.com/), [`node`](https://nodejs.org/),
  [`fnm`](https://github.com/Schniz/fnm), and
  [`npm`](https://www.npmjs.com/).
- Install [`brew cask`](https://github.com/Homebrew/homebrew-cask) and some
  useful Mac Apps such as VS Code, Spotify, Firefox, Chrome, Alfred etc.
- Install useful Extensions for [VS Code](https://code.visualstudio.com/).
- Install the [Rust](https://www.rust-lang.org/en-US/) Programming Language.

## Installation/Usage

1. Clone this project into your home directory:

   ```bash
   git clone https://github.com/JamieMason/dotfiles.git ~/dotfiles
   ```

1. Edit `USER_NAME`, `USER_EMAIL`, and `USER_URL` in `~/dotfiles/.extra` to use
   your own details.
1. Apply the dotfiles to your system using:

   ```bash
   cd ~/dotfiles && source bootstrap.sh
   # Alternatively, to update while avoiding confirmation prompts:
   # cd ~/dotfiles && set -- -f; source bootstrap.sh
   ```
