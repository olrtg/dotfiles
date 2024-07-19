# !/usr/bin/env zsh

# Load Zap
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Load FZF theme
source "$HOME/i/dotfiles/zsh/themes/bash/base16-onedark.config"

# Plugins
plug "zap-zsh/exa"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Completion plugins
plug "zsh-users/zsh-completions"

if [[ $(uname) == "Darwin" ]]; then
	export ANDROID_HOME="$HOME/Library/Android/Sdk"
else
	export ANDROID_HOME="$HOME/Android/Sdk"
fi

export EDITOR=nvim
export GIT_EDITOR="$EDITOR"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HISTFILE=~/.zsh_history
export SAVEHIST=10000000

export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed

export BAT_THEME="base16"

# Disable LunarVim's core plugins pinning
# https://www.lunarvim.org/docs/configuration/plugins/core-plugins#pinning
export LVIM_DEV_MODE=true

path=(
	${ANDROID_HOME}/emulator/
	${ANDROID_HOME}/platform-tools/
	${HOME}/.local/bin
	${HOME}/bin
	./node_modules/.bin
	$path
)

# Aliases
alias v='$EDITOR'
alias c="clear"
alias r="source ~/.zshrc"
alias x="exit"

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

alias rnand="react-native run-android"
alias rnios="react-native run-ios --simulator='iPhone 15'"
alias rncls="ncls && rm -rf ios/Pods"
alias rni="ni && npx pod-install"

alias lsios="xcrun simctl list devices"

alias nc="npm-check -u"

alias sail="[ -f sail ] && bash sail || bash vendor/bin/sail"

alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcdv="dcd -v"
alias dcdv="dcd --rmi all"

type npm >/dev/null 2>&1 && alias nrepl="NODE_PATH=$(npm root) node"

function docker_connect() {
	# Spawn a bash session inside a running container
	# USAGE: docker_connect <container_name>
	docker container exec -it "$1" /bin/bash
}

function lazygit_zed() {
  lazygit
  exit
}

# https://zsh.sourceforge.io/Doc/Release/Options.html#History
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space

# asdf
if [[ $(uname) == "Darwin" ]]; then
	. /opt/homebrew/opt/asdf/libexec/asdf.sh
else
	. "$HOME/.asdf/asdf.sh"
	fpath=(${ASDF_DIR}/completions $fpath)
	autoload -Uz compinit && compinit
fi

. ~/.asdf/plugins/java/set-java-home.zsh

# This fixes completion in macos for zsh-users/zsh-autosuggestions
# https://github.com/zsh-users/zsh-completions/issues/519
autoload -U compinit && compinit

# MOTD
echo "Alpaca went crazy! (◕('人')◕)"

# opam configuration
[[ ! -r /home/olrtg/.opam/opam-init/init.zsh ]] || source /home/olrtg/.opam/opam-init/init.zsh >/dev/null 2>/dev/null
