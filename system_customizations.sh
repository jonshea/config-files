defaults write com.apple.dashboard mcx-disabled -boolean YES # Disable Dashboard
defaults write com.apple.Dock showhidden -bool YES # Make icons of hidden aps semi-transparent in the dock
defaults write com.apple.screencapture type png # screenshots
killall Dock

sudo gem install RedCloth termios rspec sake

## iTunes
defaults write com.apple.itunes show-genre-when-browsing  -bool FALSE # disable genre panel in the iTunes browser
defaults write com.apple.itunes show-store-arrow-links -bool FALSE # turn off iTunes Store links