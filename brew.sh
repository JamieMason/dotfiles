#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# Install other useful binaries.
brew install git
brew install git-extras
brew install git-standup
brew install hub
brew install git-cal
brew install nvm
brew install tree

# Remove outdated versions from the cellar.
brew cleanup

# install latest LTS node
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"
[ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh"

read -p "Install node LTS and latest npm (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  nvm install --lts --latest-npm
  nvm alias default "$(node -v)"
  sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
fi

read -p "Install useful global npm packages (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  npm i -g commit-release
  npm i -g fixpack
  npm i -g http-server
  npm i -g lebab
  npm i -g npm-check-updates
  npm i -g prettier
  npm i -g rimraf
fi

# install cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Install useful casks.
brew cask install alfred
brew cask install bitbar
brew cask install caffeine
brew cask install charles
brew cask install cleanmymac
brew cask install codekit
brew cask install dash
brew cask install dashlane
brew cask install firefox
brew cask install flux
brew cask install franz
brew cask install gitup
brew cask install google-chrome
brew cask install imagealpha
brew cask install imageoptim
brew cask install iterm2-beta
brew cask install libreoffice
brew cask install macdown
brew cask install opera
brew cask install shades
brew cask install skype
brew cask install slowy
brew cask install spectacle
brew cask install spotify
brew cask install tower
brew cask install ui-browser
brew cask install virtualbox
brew cask install visual-studio-code

# Install QuickLook plugins
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install qlimagesize
brew cask install webpquicklook
brew cask install suspicious-package
brew cask install quicklookase
brew cask install qlvideo

# Remove outdated versions from the cask cellar.
brew cask cleanup

# Install VS Code Extensions
code --install-extension akamud.vscode-caniuse
code --install-extension andys8.jest-snippets
code --install-extension angryobject.react-pure-to-class-vscode
code --install-extension apollographql.vscode-apollo
code --install-extension auiworks.amvim
code --install-extension bibhasdn.unique-lines
code --install-extension christian-kohler.npm-intellisense
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension cssho.vscode-svgviewer
code --install-extension dakara.transformer
code --install-extension dbaeumer.vscode-eslint
code --install-extension dzannotti.vscode-babel-coloring
code --install-extension eamodio.gitlens
code --install-extension eg2.tslint
code --install-extension esbenp.prettier-vscode
code --install-extension idleberg.applescript
code --install-extension kisstkondoros.vscode-codemetrics
code --install-extension kumar-harsh.graphql-for-vscode
code --install-extension leizongmin.node-module-intellisense
code --install-extension ms-vscode.sublime-keybindings
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension PKief.material-icon-theme
code --install-extension rust-lang.rust
code --install-extension searKing.preview-vscode
code --install-extension teabyii.ayu
code --install-extension wix.vscode-import-cost
code --install-extension wmaurer.change-case

# Install Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
