.PHONY: install brew brew-restore macos karabiner

# Run dotbot's script
install:
	./install

# Install dependencies
install-deps:
	rustup-init
	./dependencies/install-deps.sh
	/bin/bash -c "$$(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)"

# Save snapshot of all Homebrew packages to macos/Brewfile
brew:
	brew bundle dump -f --file=macos/Brewfile
	brew bundle --force cleanup --file=macos/Brewfile

# Restore Homebrew packages
brew-restore:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew update
	brew upgrade
	brew bundle install --file=macos/Brewfile
	brew cleanup

# Set MacOS defaults
macos:
	./macos/set-defaults.sh

# Setup karabiner's commands 
karabiner:
	deno run --allow-env --allow-read --allow-write karabiner/karabiner.ts
