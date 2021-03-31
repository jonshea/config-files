
## https://github.com/nnja/new-computer

echo "Installing brew..."

if test ! $(which brew)
then
	## Don't prompt for confirmation when installing homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
fi

# Latest brew, install brew cask
brew upgrade
brew update
brew install cask

brew tap homebrew/cask-versions

brew install --cask noisy
brew install --cask alfred
brew install --cask 1password
brew install --cask firefox
brew install --cask google-chrome
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask imageoptim
brew install --cask imagealpha
brew install --cask grandperspective
brew install --cask vlc
brew install --cask superduper
brew install --cask cyberduck
brew install --cask slack
brew install --cask macdown
brew install --cask kaleidoscope
brew install --cask arq
brew install --cask choosy

brew install --cask karabiner-elements
# brew install --cask betterzip
# brew install --cask discord

brew install git
brew install wget
brew install zsh
brew install zsh-completions
brew install tmux
brew install grep --with-default-names
brew install ispell
brew install magic-wormhole

brew install fzf
brew install fd
brew install ripgrep

brew tap aykamko/tag-ag
brew install tag-ag

# Python
# See https://news.ycombinator.com/item?id=25597246
brew install python
brew install pyenv

# https://github.com/AdoptOpenJDK/homebrew-openjdk
# https://stackoverflow.com/questions/52524112/how-do-i-install-java-on-mac-osx-allowing-version-switching/52524114#52524114
brew tap AdoptOpenJDK/openjdk
brew install adoptopenjdk

# brew install --cask karabiner-elements  # remap keys, emacs shortcuts

### Quicklook plugins https://github.com/sindresorhus/quick-look-plugins
# brew install --cask qlcolorcode # syntax highlighting in preview
# brew install --cask qlstephen  # preview plaintext files without extension
# brew install --cask qlmarkdown  # preview markdown files
# brew install --cask quicklook-json  # preview json files
# brew install --cask epubquicklook  # preview epubs, make nice icons
# brew install --cask quicklook-csv  # preview csvs

brew cleanup
