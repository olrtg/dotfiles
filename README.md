# Dotfiles

> Personal configuration for Neovim, Zed, Ghostty, Zsh, Git, and mise.

## Usage

Prerequisites: macOS with git (`xcode-select --install`).

```sh
git clone https://github.com/olrtg/dotfiles.git ~/d/dotfiles
cd ~/d/dotfiles
make bootstrap
```

`make bootstrap` installs Homebrew and the `macos/Brewfile`, symlinks every config into `$HOME`, and installs the mise toolchain. To only refresh the symlinks, run `./install`. It is safe to re-run, backs up any real file it would replace, and removes dangling links left by deleted configs. The link table lives at the top of `install`.

Secrets and machine-specific settings go in `~/.zshrc.local`, which is sourced last and never committed.

### Agents

Skills live in `agents/skills`, linked to `~/.agents/skills` and into `~/.claude/skills`. Skills installed with the `skills` CLI land in the repo, so commit them like any other change. `agents/claude/settings.json` is Claude Code's settings, including its plugins.

MCP servers for Claude Code and Codex are listed in `agents/mcp.sh`. Their configs also hold login state, so they are not linked. Run `make mcp` after adding a server to the script. Existing servers are skipped, and new HTTP servers open a browser to log in.

### Keeping apps in sync

`macos/Brewfile` lists every Homebrew package, app, and Mac App Store app. After installing or removing something, run `make brew` and commit the diff. `make drift` shows what differs between the machine and the Brewfile without changing anything.

These apps have no Homebrew cask and need a manual install:

- Amp
- Bartender 6 (the `bartender` cask installs version 7)
- Copper
- Fred
- Maestro Studio
- T3 Code (Alpha) (the `t3-code` cask installs the Beta)

### Other tasks

_[See Makefile](./Makefile)_
