#!/bin/sh

if [ "$(uname -s)" != "Darwin" ]; then
  exit 0
fi

echo "> Enabling key repetion for Visual Studio Code in favor of VSCodeVim"
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
