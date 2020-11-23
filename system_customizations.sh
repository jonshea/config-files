# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Disable transparency in the menu bar and elsewhere on Yosemite
defaults write com.apple.universalaccess reduceTransparency -bool true

## Dock customizations
defaults write com.apple.dashboard mcx-disabled -boolean YES # Disable Dashboard
defaults write com.apple.Dock showhidden -bool YES # Make icons of hidden aps semi-transparent in the dock
killall Dock

# Show extended print dialog by default
defaults write -g PMPrintingExpandedStateForPrint -bool TRUE

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Show extended save dialog by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool TRUE
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Don’t use iCloud as the default save location
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Show full path in Finder window title bars
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder

## iTunes
defaults write com.apple.itunes show-genre-when-browsing -bool FALSE # disable genre panel in the iTunes browser
defaults write com.apple.itunes show-store-arrow-links -bool FALSE # turn off iTunes Store links
defaults write com.apple.iTunes hide-ping-dropdown -bool TRUE
defaults write com.apple.iTunes disablePingSidebar -bool TRUE

defaults write com.apple.Safari IncludeInternalDebugMenu 1

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

## Disable mouse acceleration, according to Cameron Mulhern
defaults write NSGlobalDomain com.apple.mouse.scaling -1

## How to prevent .DS_Store file creation over network connections
## https://support.apple.com/en-us/HT1629
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable smart quotes and smart dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Use function F1, F2, etc keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Load new settings before rebuilding the index
killall mds


# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1


defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false



## https://github.com/mathiasbynens/dotfiles
## https://github.com/nnja/new-computer
