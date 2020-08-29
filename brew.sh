#!/usr/bin/env bash

# Remove all Dock Icons
defaults write com.apple.dock persistent-apps -array
killall Dock

read -p "Install brew? (Enter y or n) " INSTALL_BREW
read -p "Install useful brew formulas? (Enter y or n) " INSTALL_BREW_FORMALAS
read -p "Install nvm, Node.js, and npm? (Enter y or n) " INSTALL_NODE_LTS
read -p "Install useful global npm packages? (Enter y or n) " INSTALL_NPM_DEPS
read -p "Install useful casks? (Enter y or n) " INSTALL_CASKS
read -p "Install VS Code Extensions? (Enter y or n) " INSTALL_VS_CODE_EXTENSIONS
read -p "Install Rust? (Enter y or n) " INSTALL_RUST

if [ "$INSTALL_BREW" = "y" ]; then
  # install homebrew
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade
fi

if [ "$INSTALL_BREW_FORMALAS" = "y" ]; then
  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  brew install coreutils
  ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
  # Install some other useful utilities like `sponge`.
  brew install moreutils
  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  brew install findutils
  # Install GNU `sed`, overwriting the built-in `sed`.
  brew install gnu-sed
  # Install Bash 4.
  # Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
  # running `chsh`.
  brew install bash
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

  # Install other useful binaries.
  brew install duti
  brew install git
  brew install git-extras
  brew install git-standup
  brew install hub
  brew install git-cal
  brew install pup
  brew install tree
  brew install nektos/tap/act

  # Remove outdated versions from the cellar.
  brew cleanup
fi

if [ "$INSTALL_NODE_LTS" = "y" ]; then
  brew install nvm
  # install latest LTS node
  export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"
  [ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh"

  nvm install --lts --latest-npm
  nvm alias default "$(node -v)"
  sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
fi

if [ "$INSTALL_NPM_DEPS" = "y" ]; then
  npm i -g \
    commit-release \
    find-unused-exports \
    http-server \
    lebab \
    npm-check-updates \
    organize-imports-cli \
    prettier \
    svgo \
    syncpack \
    yarn
fi

if [ "$INSTALL_CASKS" = "y" ]; then
  brew cask install alfred
  brew cask install bitbar
  brew cask install caffeine
  brew cask install charles
  brew cask install cheatsheet
  brew cask install cleanmymac
  brew cask install dash
  brew cask install discord
  brew cask install firefox
  brew cask install flux
  brew cask install gitup
  brew cask install google-chrome
  brew cask install imagealpha
  brew cask install imageoptim
  brew cask install istumbler
  brew cask install iterm2
  brew cask install kap
  brew cask install keycastr
  brew cask install libreoffice
  brew cask install postman
  brew cask install slack
  brew cask install spectacle
  brew cask install spotify
  brew cask install sublime-text-dev
  brew cask install tower
  brew cask install visual-studio-code

  # Cask version of Dashlane is buggy
  open https://www.dashlane.com/download

  # Remove outdated versions from the cask cellar.
  brew cask cleanup
fi

if [ "$INSTALL_VS_CODE_EXTENSIONS" = "y" ]; then
  # Crudely remove any not in this list by removing all
  for i in $(code --list-extensions); do
    echo "code --uninstall-extension $i"
  done

  # (Re)install
  code --install-extension andys8.jest-snippets
  code --install-extension annsk.alignment
  code --install-extension ardenivanov.svelte-intellisense
  code --install-extension Asuka.insertnumbers
  code --install-extension auiworks.amvim
  code --install-extension bibhasdn.unique-lines
  code --install-extension bierner.markdown-preview-github-styles
  code --install-extension cmstead.jsrefactor
  code --install-extension CoenraadS.bracket-pair-colorizer
  code --install-extension cssho.vscode-svgviewer
  code --install-extension dakara.transformer
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension dsznajder.es7-react-js-snippets
  code --install-extension eamodio.gitlens
  code --install-extension esbenp.prettier-vscode
  code --install-extension JamesBirtles.svelte-vscode
  code --install-extension jaredkent.laserwave
  code --install-extension kumar-harsh.graphql-for-vscode
  code --install-extension msjsdiag.debugger-for-chrome
  code --install-extension PKief.material-icon-theme
  code --install-extension rust-lang.rust
  code --install-extension sburg.vscode-javascript-booster
  code --install-extension stkb.rewrap
  code --install-extension Tyriar.lorem-ipsum
  code --install-extension wmaurer.change-case

  # Configure VS Code
  cp -f ./init/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
  cp -f ./init/JamieMason.code-snippets "$HOME/Library/Application Support/Code/User/snippets/JamieMason.code-snippets"
fi

if [ "$INSTALL_RUST" = "y" ]; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  rustup update
fi

# Default Sublime Text
duti -s com.sublimetext.3 .aliases all
duti -s com.sublimetext.3 .babelrc all
duti -s com.sublimetext.3 .bash_profile all
duti -s com.sublimetext.3 .bash_prompt all
duti -s com.sublimetext.3 .bashrc all
duti -s com.sublimetext.3 .cfignore all
duti -s com.sublimetext.3 .compilerc all
duti -s com.sublimetext.3 .crt all
duti -s com.sublimetext.3 .csr all
duti -s com.sublimetext.3 .css all
duti -s com.sublimetext.3 .curlrc all
duti -s com.sublimetext.3 .dockerignore all
duti -s com.sublimetext.3 .editorconfig all
duti -s com.sublimetext.3 .ejs all
duti -s com.sublimetext.3 .env all
duti -s com.sublimetext.3 .eot all
duti -s com.sublimetext.3 .eslintignore all
duti -s com.sublimetext.3 .eslintrc all
duti -s com.sublimetext.3 .example all
duti -s com.sublimetext.3 .exports all
duti -s com.sublimetext.3 .extra all
duti -s com.sublimetext.3 .functions all
duti -s com.sublimetext.3 .gdbinit all
duti -s com.sublimetext.3 .git-commit-template all
duti -s com.sublimetext.3 .gitattributes all
duti -s com.sublimetext.3 .gitconfig all
duti -s com.sublimetext.3 .gitignore all
duti -s com.sublimetext.3 .graphql all
duti -s com.sublimetext.3 .gvimrc all
duti -s com.sublimetext.3 .hgignore all
duti -s com.sublimetext.3 .hushlogin all
duti -s com.sublimetext.3 .huskyrc all
duti -s com.sublimetext.3 .ico all
duti -s com.sublimetext.3 .idx all
duti -s com.sublimetext.3 .info all
duti -s com.sublimetext.3 .inputrc all
duti -s com.sublimetext.3 .itermcolors all
duti -s com.sublimetext.3 .js all
duti -s com.sublimetext.3 .jshintrc all
duti -s com.sublimetext.3 .json all
duti -s com.sublimetext.3 .jsx all
duti -s com.sublimetext.3 .key all
duti -s com.sublimetext.3 .lintstagedrc all
duti -s com.sublimetext.3 .local all
duti -s com.sublimetext.3 .lock all
duti -s com.sublimetext.3 .log all
duti -s com.sublimetext.3 .macos all
duti -s com.sublimetext.3 .mailmap all
duti -s com.sublimetext.3 .map all
duti -s com.sublimetext.3 .md all
duti -s com.sublimetext.3 .mdx all
duti -s com.sublimetext.3 .nimbus all
duti -s com.sublimetext.3 .node-version all
duti -s com.sublimetext.3 .npmignore all
duti -s com.sublimetext.3 .npmrc all
duti -s com.sublimetext.3 .nvmrc all
duti -s com.sublimetext.3 .nycrc all
duti -s com.sublimetext.3 .opts all
duti -s com.sublimetext.3 .osx all
duti -s com.sublimetext.3 .otf all
duti -s com.sublimetext.3 .pack all
duti -s com.sublimetext.3 .pem all
duti -s com.sublimetext.3 .placeholder all
duti -s com.sublimetext.3 .prettierignore all
duti -s com.sublimetext.3 .prettierrc all
duti -s com.sublimetext.3 .sample all
duti -s com.sublimetext.3 .screenrc all
duti -s com.sublimetext.3 .scss all
duti -s com.sublimetext.3 .sh all
duti -s com.sublimetext.3 .sketch all
duti -s com.sublimetext.3 .snap all
duti -s com.sublimetext.3 .stylelintrc all
duti -s com.sublimetext.3 .svg all
duti -s com.sublimetext.3 .template all
duti -s com.sublimetext.3 .terminal all
duti -s com.sublimetext.3 .test all
duti -s com.sublimetext.3 .toml all
duti -s com.sublimetext.3 .ts all
duti -s com.sublimetext.3 .tsx all
duti -s com.sublimetext.3 .ttf all
duti -s com.sublimetext.3 .txt all
duti -s com.sublimetext.3 .vim all
duti -s com.sublimetext.3 .vimrc all
duti -s com.sublimetext.3 .wgetrc all
duti -s com.sublimetext.3 .xml all
duti -s com.sublimetext.3 .yarnrc all
duti -s com.sublimetext.3 .yml all
