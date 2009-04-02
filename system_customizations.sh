## Dock customizations
defaults write com.apple.dashboard mcx-disabled -boolean YES # Disable Dashboard
defaults write com.apple.Dock showhidden -bool YES # Make icons of hidden aps semi-transparent in the dock
defaults write com.apple.screencapture type png # screenshots
killall Dock

# Show extended print dialog by default
defaults write -g PMPrintingExpandedStateForPrint -bool TRUE

# Show extended save dialog by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool TRUE

# Show pull path in Finder window title bars
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder

sudo gem install RedCloth termios rspec sake

## iTunes
defaults write com.apple.itunes show-genre-when-browsing  -bool FALSE # disable genre panel in the iTunes browser
defaults write com.apple.itunes show-store-arrow-links -bool FALSE # turn off iTunes Store links

defaults write com.apple.Xcode PBXCustomTemplateMacroDefinitions '{ "ORGANIZATIONNAME" = "ExpanDrive Inc" ; }'
