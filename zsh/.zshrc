# Load Zap
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/fnm"
plug "wintermi/zsh-rust"
plug "wintermi/zsh-golang"
plug "wintermi/zsh-brew"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/exa"
plug "Aloxaf/fzf-tab"

if [[ `uname` == "Darwin" ]]; then
  export ANDROID_HOME="$HOME/Library/Android/Sdk"
else
  export ANDROID_HOME="$HOME/Android/Sdk"
fi

export EDITOR=lvim
export GIT_EDITOR="$EDITOR"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# FZF Nord
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
	$path
)

# Aliases
alias v='$EDITOR'
alias c="clear"
alias r="source ~/.zshrc"
alias x="exit"

alias lzd="lazydocker"
alias lzg="lazygit"

alias s="nr start"
alias d="nr dev"
alias b="nr build"

alias rnand="npx react-native run-android"
alias rnios="npx react-native run-ios"
alias rncls="rm -rf node_modules && rm -rf ios/Pods"
alias rni="ni && npx pod-install"

alias nc='npm-check -u'

alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'

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

# MOTD
echo "Alpaca went crazy! (◕('人')◕)"
