# !/usr/bin/env zsh

source "$HOME/d/dotfiles/zsh/themes/bash/base16-onedark.config" # Load FZF theme

# Plugins
source "$HOME/d/dotfiles/zsh/fzf-tab/fzf-tab.plugin.zsh"
source "$HOME/d/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$HOME/d/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
source "$HOME/d/dotfiles/zsh/zsh-completions/zsh-completions.plugin.zsh"
source <(fzf --zsh)
source <(mise completion zsh)

# Global variables
export EDITOR=nvim
export GIT_EDITOR="$EDITOR"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HISTFILE=~/.zsh_history
export SAVEHIST=10000000
export BAT_THEME="base16"

# Android SDK
if [[ $(uname) == "Darwin" ]]; then
	export ANDROID_HOME="$HOME/Library/Android/sdk"
else
	export ANDROID_HOME="$HOME/Android/sdk"
fi

# $PATH
path=(
	${ANDROID_HOME}/emulator/
	${ANDROID_HOME}/platform-tools/
	/opt/homebrew/opt/libpq/bin # postgres client
	$path
)

# Aliases
alias v='$EDITOR'
alias r="source ~/.zshrc"

alias lzg="lazygit"

alias gc="git clone"
alias gl="git pull"
alias gs="git switch"
alias gss="git status -s"

alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias t="nr test"

alias ncls="rm -rf node_modules"

alias lsios="xcrun simctl list devices"

alias nc="npm-check -u"

alias sail="[ -f sail ] && bash sail || bash vendor/bin/sail"

alias dcu="docker compose up"
alias dcud="dcu -d"
alias dcd="docker compose down"
alias dcdv="dcd -v"
alias dcda="dcd --rmi all"

type npm >/dev/null 2>&1 && alias nrepl="NODE_PATH=$(npm root) node"

# ZSH options
# https://zsh.sourceforge.io/Doc/Release/Options.html#History
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space

# Enable completion
autoload -Uz compinit
compinit

# Activate
eval "$(starship init zsh)" # Load starship
eval "$(mise activate zsh)" # Load mise

# MOTD
echo "Alpaca went crazy! (◕('人')◕)"
