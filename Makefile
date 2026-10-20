.PHONY: bootstrap install brew brew-restore macos

# Set up a brand new machine
bootstrap: brew-restore install
	mise install

# Symlink dotfiles into $HOME
install:
	./install

# Save snapshot of all Homebrew packages to macos/Brewfile
brew:
	brew bundle dump -f --file=macos/Brewfile
	sed -i '' -E '/^(npm|go|cargo) /d' macos/Brewfile

# Restore Homebrew packages
brew-restore:
	command -v brew >/dev/null || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$$(/opt/homebrew/bin/brew shellenv)" && brew update && brew bundle install --file=macos/Brewfile && brew cleanup

# Set MacOS defaults
macos:
	./macos/set-defaults.sh
