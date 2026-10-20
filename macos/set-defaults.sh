#!/bin/sh

if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

# Close System Settings so it doesn't override the settings we're about to change
osascript -e 'tell application "System Settings" to quit'

# https://macos-defaults.com/
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

echo "> Keyboard"

echo "  > Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "  > Disable smart quotes, smart dashes and double-space period"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo "> Dock"

echo "  > Autohide Dock"
defaults write com.apple.dock autohide -bool true

echo "  > Show the Dock without delay"
defaults write com.apple.dock autohide-delay -float 0

echo "  > Set icon size to 48px"
defaults write com.apple.dock tilesize -int 48

echo "  > Do not show recent apps"
defaults write com.apple.dock show-recents -bool false

echo "> Finder"

echo "  > Show hidden files"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "  > Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "  > Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "  > Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  > Start the path bar at ~"
defaults write com.apple.finder PathBarRootAtHome -bool true

echo "  > Use list view"
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv

echo "  > Search the current folder"
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

echo "  > Keep folders on top"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo "  > Do not write .DS_Store files on network drives"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "> Screen"

echo "  > Do not dim the display on battery"
sudo pmset -b lessbright 0

echo "  > Require password immediately after sleep or screen saver begins"
sysadminctl -screenLock immediate -password -

echo ""
echo "You may want to restart your computer now."

for app in "Dock" "Finder"; do
	killall "${app}"
done
