# !/usr/bin/env zsh

# Load Zap
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Plugins
plug "zap-zsh/exa"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "wintermi/zsh-brew"
plug "wintermi/zsh-rust"
plug "zap-zsh/zap-prompt"
# plug "wintermi/zsh-golang"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

plug "olrtg/zsh-fvm"

# Plugins in development
# plug ~/code/zsh-fvm/zsh-fvm.plugin.zsh

if [[ $(uname) == "Darwin" ]]; then
	export ANDROID_HOME="$HOME/Library/Android/Sdk"
else
	export ANDROID_HOME="$HOME/Android/Sdk"
fi

export EDITOR=lvim
export GIT_EDITOR="$EDITOR"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HISTFILE=~/.zsh_history
export SAVEHIST=1000000
export FLYCTL_INSTALL="/home/olrtg/.fly"

export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed

# FZF Tokionight
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
	--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
	--color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff
	--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff 
	--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'

export BAT_THEME="base16"

path=(
	${ANDROID_HOME}/emulator/
	${ANDROID_HOME}/platform-tools/
	${HOME}/.local/bin
	${HOME}/bin
	${FLYCTL_INSTALL}/bin
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

alias rnand="npx react-native run-android"
alias rnios="npx react-native run-ios"
alias rncls="ncls && rm -rf ios/Pods"
alias rni="ni && npx pod-install"

alias nc="npm-check -u"

alias sail="[ -f sail ] && bash sail || bash vendor/bin/sail"

alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcdv="dcd -v"
alias dcdv="dcd --rmi all"

# BUG: Doesn't work with arguments
function patchfont() {
	# Patch a normal font with nerdfont
	# USAGE: patchfont <input_folder_path> <output_folder_path>
	docker run --rm -v "$1":/in -v "$2":/out nerdfonts/patcher
}

function docker_connect() {
	# Spawn a bash session inside a running container
	# USAGE: docker_connect <container_name>
	docker container exec -it "$1" /bin/bash
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

# MOTD
echo "Alpaca went crazy! (◕('人')◕)"

# opam configuration
[[ ! -r /home/olrtg/.opam/opam-init/init.zsh ]] || source /home/olrtg/.opam/opam-init/init.zsh >/dev/null 2>/dev/null
