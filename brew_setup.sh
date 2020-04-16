
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

# brew cask install betterzip
# brew cask install discord

brew install git
brew install wget
brew install zsh
brew install tmux
brew install grep --with-default-names
brew install ispell

brew install python
brew install pyenv

# brew cask install karabiner-elements  # remap keys, emacs shortcuts

### Quicklook plugins https://github.com/sindresorhus/quick-look-plugins
# brew cask install qlcolorcode # syntax highlighting in preview
# brew cask install qlstephen  # preview plaintext files without extension
# brew cask install qlmarkdown  # preview markdown files
# brew cask install quicklook-json  # preview json files
# brew cask install epubquicklook  # preview epubs, make nice icons
# brew cask install quicklook-csv  # preview csvs

brew cleanup