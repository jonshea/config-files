
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

brew cask install noisy
brew cask alfred
brew cask 1password
brew cask install firefox
brew cask install google-chrome
brew cask install iterm2
brew cask install visual-studio-code
brew cask install imageoptim
brew cask install imagealpha
brew cask install grandperspective
brew cask install vlc
brew cask install superduper
brew cask install cyberduck
brew cask install slack
brew cask install macdown
brew cask install kaleidoscope
brew cask install arq
brew cask install choosy
brew cask install

# brew cask install betterzip
# brew cask install discord

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

brew install python
brew install pyenv

# https://github.com/AdoptOpenJDK/homebrew-openjdk
# https://stackoverflow.com/questions/52524112/how-do-i-install-java-on-mac-osx-allowing-version-switching/52524114#52524114
brew tap AdoptOpenJDK/openjdk
brew install adoptopenjdk

# brew cask install karabiner-elements  # remap keys, emacs shortcuts

### Quicklook plugins https://github.com/sindresorhus/quick-look-plugins
# brew cask install qlcolorcode # syntax highlighting in preview
# brew cask install qlstephen  # preview plaintext files without extension
# brew cask install qlmarkdown  # preview markdown files
# brew cask install quicklook-json  # preview json files
# brew cask install epubquicklook  # preview epubs, make nice icons
# brew cask install quicklook-csv  # preview csvs

brew cleanup
