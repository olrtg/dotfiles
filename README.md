# Dotfiles

> Personal configuration for Neovim, Zed, Ghostty, Zsh, tmux, Git, and mise.

## Usage

Prerequisites: macOS with git (`xcode-select --install`).

```sh
git clone https://github.com/olrtg/dotfiles.git ~/d/dotfiles
cd ~/d/dotfiles
make bootstrap
```

`make bootstrap` installs Homebrew and the `macos/Brewfile`, symlinks every config into `$HOME`, and installs the mise toolchain. To only refresh the symlinks, run `./install`. It is safe to re-run, backs up any real file it would replace, and removes dangling links left by deleted configs. The link table lives at the top of `install`.

Secrets and machine-specific settings go in `~/.zshrc.local`, which is sourced last and never committed.

### Other tasks

_[See Makefile](./Makefile)_
