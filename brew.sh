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
  brew install alfred
  brew install bitbar
  brew install caffeine
  brew install charles
  brew install cheatsheet
  brew install cleanmymac
  brew install dash
  brew install discord
  brew install firefox
  brew install flux
  brew install gitup
  brew install google-chrome
  brew install imagealpha
  brew install imageoptim
  brew install istumbler
  brew install iterm2
  brew install kap
  brew install keycastr
  brew install libreoffice
  brew install postman
  brew install slack
  brew install spectacle
  brew install spotify
  brew install sublime-text-dev
  brew install tower
  brew install visual-studio-code

  # Cask version of Dashlane is buggy
  open https://www.dashlane.com/download

  # Remove outdated versions from the cask cellar.
  brew cleanup
fi

if [ "$INSTALL_VS_CODE_EXTENSIONS" = "y" ]; then
  # Crudely remove any not in this list by removing all
  for i in $(code --list-extensions); do
    echo "code --uninstall-extension $i"
  done

  # (Re)install
  code --install-extension andys8.jest-snippets
  code --install-extension annsk.alignment
  code --install-extension Asuka.insertnumbers
  code --install-extension auiworks.amvim
  code --install-extension bibhasdn.unique-lines
  code --install-extension bierner.markdown-preview-github-styles
  code --install-extension cmstead.jsrefactor
  code --install-extension CoenraadS.bracket-pair-colorizer
  code --install-extension cssho.vscode-svgviewer
  code --install-extension dakara.transformer
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension deerawan.vscode-dash
  code --install-extension DigitalBrainstem.javascript-ejs-support
  code --install-extension dsznajder.es7-react-js-snippets
  code --install-extension eamodio.gitlens
  code --install-extension esbenp.prettier-vscode
  code --install-extension Gruntfuggly.todo-tree
  code --install-extension heybourn.headwind
  code --install-extension jaredkent.laserwave
  code --install-extension kumar-harsh.graphql-for-vscode
  code --install-extension msjsdiag.debugger-for-chrome
  code --install-extension PKief.material-icon-theme
  code --install-extension pnp.polacode
  code --install-extension ronnidc.nunjucks
  code --install-extension rust-lang.rust
  code --install-extension sburg.vscode-javascript-booster
  code --install-extension stkb.rewrap
  code --install-extension svelte.svelte-vscode
  code --install-extension Tyriar.lorem-ipsum
  code --install-extension VisualStudioExptTeam.vscodeintellicode
  code --install-extension WakaTime.vscode-wakatime
  code --install-extension wmaurer.change-case

  # Configure VS Code
  cp -f ./init/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
  cp -f ./init/JamieMason.code-snippets "$HOME/Library/Application Support/Code/User/snippets/JamieMason.code-snippets"

  duti -s com.microsoft.VSCode .aliases all
  duti -s com.microsoft.VSCode .babelrc all
  duti -s com.microsoft.VSCode .bash_profile all
  duti -s com.microsoft.VSCode .bash_prompt all
  duti -s com.microsoft.VSCode .bashrc all
  duti -s com.microsoft.VSCode .cfignore all
  duti -s com.microsoft.VSCode .compilerc all
  duti -s com.microsoft.VSCode .crt all
  duti -s com.microsoft.VSCode .csr all
  duti -s com.microsoft.VSCode .css all
  duti -s com.microsoft.VSCode .curlrc all
  duti -s com.microsoft.VSCode .dockerignore all
  duti -s com.microsoft.VSCode .editorconfig all
  duti -s com.microsoft.VSCode .ejs all
  duti -s com.microsoft.VSCode .env all
  duti -s com.microsoft.VSCode .eot all
  duti -s com.microsoft.VSCode .eslintignore all
  duti -s com.microsoft.VSCode .eslintrc all
  duti -s com.microsoft.VSCode .example all
  duti -s com.microsoft.VSCode .exports all
  duti -s com.microsoft.VSCode .extra all
  duti -s com.microsoft.VSCode .functions all
  duti -s com.microsoft.VSCode .gdbinit all
  duti -s com.microsoft.VSCode .git-commit-template all
  duti -s com.microsoft.VSCode .gitattributes all
  duti -s com.microsoft.VSCode .gitconfig all
  duti -s com.microsoft.VSCode .gitignore all
  duti -s com.microsoft.VSCode .graphql all
  duti -s com.microsoft.VSCode .gvimrc all
  duti -s com.microsoft.VSCode .hgignore all
  duti -s com.microsoft.VSCode .hushlogin all
  duti -s com.microsoft.VSCode .huskyrc all
  duti -s com.microsoft.VSCode .ico all
  duti -s com.microsoft.VSCode .idx all
  duti -s com.microsoft.VSCode .info all
  duti -s com.microsoft.VSCode .inputrc all
  duti -s com.microsoft.VSCode .itermcolors all
  duti -s com.microsoft.VSCode .js all
  duti -s com.microsoft.VSCode .jshintrc all
  duti -s com.microsoft.VSCode .json all
  duti -s com.microsoft.VSCode .jsx all
  duti -s com.microsoft.VSCode .key all
  duti -s com.microsoft.VSCode .lintstagedrc all
  duti -s com.microsoft.VSCode .local all
  duti -s com.microsoft.VSCode .lock all
  duti -s com.microsoft.VSCode .log all
  duti -s com.microsoft.VSCode .macos all
  duti -s com.microsoft.VSCode .mailmap all
  duti -s com.microsoft.VSCode .map all
  duti -s com.microsoft.VSCode .md all
  duti -s com.microsoft.VSCode .mdx all
  duti -s com.microsoft.VSCode .nimbus all
  duti -s com.microsoft.VSCode .node-version all
  duti -s com.microsoft.VSCode .npmignore all
  duti -s com.microsoft.VSCode .npmrc all
  duti -s com.microsoft.VSCode .nvmrc all
  duti -s com.microsoft.VSCode .nycrc all
  duti -s com.microsoft.VSCode .opts all
  duti -s com.microsoft.VSCode .osx all
  duti -s com.microsoft.VSCode .otf all
  duti -s com.microsoft.VSCode .pack all
  duti -s com.microsoft.VSCode .pem all
  duti -s com.microsoft.VSCode .placeholder all
  duti -s com.microsoft.VSCode .prettierignore all
  duti -s com.microsoft.VSCode .prettierrc all
  duti -s com.microsoft.VSCode .sample all
  duti -s com.microsoft.VSCode .screenrc all
  duti -s com.microsoft.VSCode .scss all
  duti -s com.microsoft.VSCode .sh all
  duti -s com.microsoft.VSCode .sketch all
  duti -s com.microsoft.VSCode .snap all
  duti -s com.microsoft.VSCode .stylelintrc all
  duti -s com.microsoft.VSCode .svg all
  duti -s com.microsoft.VSCode .template all
  duti -s com.microsoft.VSCode .terminal all
  duti -s com.microsoft.VSCode .test all
  duti -s com.microsoft.VSCode .toml all
  duti -s com.microsoft.VSCode .ts all
  duti -s com.microsoft.VSCode .tsx all
  duti -s com.microsoft.VSCode .ttf all
  duti -s com.microsoft.VSCode .txt all
  duti -s com.microsoft.VSCode .vim all
  duti -s com.microsoft.VSCode .vimrc all
  duti -s com.microsoft.VSCode .wgetrc all
  duti -s com.microsoft.VSCode .xml all
  duti -s com.microsoft.VSCode .yarnrc all
  duti -s com.microsoft.VSCode .yml all
fi

if [ "$INSTALL_RUST" = "y" ]; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  rustup update
fi
