## Dock customizations
defaults write com.apple.dashboard mcx-disabled -boolean YES # Disable Dashboard
defaults write com.apple.Dock showhidden -bool YES # Make icons of hidden aps semi-transparent in the dock
defaults write com.apple.screencapture type png # screenshots
killall Dock

# Show extended print dialog by default
defaults write -g PMPrintingExpandedStateForPrint -bool TRUE

# Show extended save dialog by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool TRUE

# Don’t use iCloud as the default save location
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Show pull path in Finder window title bars
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder

## iTunes
defaults write com.apple.itunes show-genre-when-browsing -bool FALSE # disable genre panel in the iTunes browser
defaults write com.apple.itunes show-store-arrow-links -bool FALSE # turn off iTunes Store links
defaults write com.apple.iTunes hide-ping-dropdown -bool TRUE
defaults write com.apple.iTunes disablePingSidebar -bool TRUE

## Set cmd-V to "Paste and Match Style"
# defaults write .GlobalPreferences -dict-add NSUserKeyEquivalents “Paste and Match Style” -string “@v”

## Disable "wake on lid open"
# sudo pmset -a lidwake 0

## Make it so that when you copy an address out of Mail.app it doesn't copy the name
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool NO

## Enable Mail.app plugins
defaults write com.apple.mail EnableBundles -bool true
defaults write com.apple.mail BundleCompatibilityVersion 3

## Add github to gem-source
gem sources -a http://gems.github.com

## Disable download quarantine
defaults write com.apple.LaunchServices LSQuarantine -bool NO

