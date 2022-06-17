#!/bin/sh

if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# https://macos-defaults.com/
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

echo "> Keyboard"

echo "  > Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "> Dock & Menu Bar"

echo "  > Autohide Menu Bar"
defaults write NSGlobalDomain _HIHideMenuBar -bool true

echo "  > Autohide Dock"
defaults write com.apple.dock autohide -bool true

echo "  > Set icon size to 48px"
defaults write com.apple.dock tilesize -int 48

echo "  > Do not show recent apps"
defaults write com.apple.dock show-recents -bool false

echo "> Finder"

echo "  > Show hidden files"
defaults write com.apple.finder AppleShowAllFiles true

echo "  > Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "  > Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "  > Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  > Start the path bar at ~"
defaults write com.apple.finder PathBarRootAtHome -bool true

echo "> Screen"

echo "  > Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "  > Enable subpixel font rendering on non-Apple LCDs"
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

echo ""
echo "You may want to restart your computer now."

for app in "Dock" "Finder"; do
	killall "${app}"
done
