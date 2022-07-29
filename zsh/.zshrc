# Antibody
source <(antibody init)

# Plugins
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh" # setup required env var for oh-my-zsh plugins
export ZSH

antibody bundle robbyrussell/oh-my-zsh
antibody bundle robbyrussell/oh-my-zsh path:plugins/brew
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker-compose
antibody bundle robbyrussell/oh-my-zsh path:plugins/git
antibody bundle robbyrussell/oh-my-zsh path:plugins/ionic
antibody bundle robbyrussell/oh-my-zsh path:plugins/react-native
antibody bundle robbyrussell/oh-my-zsh path:plugins/npm
antibody bundle robbyrussell/oh-my-zsh path:plugins/ng
antibody bundle robbyrussell/oh-my-zsh path:plugins/tmux
antibody bundle robbyrussell/oh-my-zsh path:plugins/tmuxinator
antibody bundle robbyrussell/oh-my-zsh path:plugins/vscode
antibody bundle robbyrussell/oh-my-zsh path:plugins/z
antibody bundle jimeh/zsh-peco-history
antibody bundle mroth/evalcache
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-syntax-highlighting # this needs to be the last module

# Configuration
zstyle ':completion:*' completer _expand_alias _complete _ignored # expand alias with tab

export ANDROID_HOME="$HOME/Library/Android/sdk"
export EDITOR=lvim
export GIT_EDITOR="$EDITOR"

path=(
	${ANDROID_HOME}/tools/
	${ANDROID_HOME}/platform-tools/
	${HOME}/.local/bin
	$(go env GOPATH)/bin
	$path
)

# Aliases
alias v='$EDITOR'
alias vim='$EDITOR'
alias cls="clear"
alias ls="exa --oneline --color=always --icons --header --git --long --no-permissions --no-user"
alias rs="source ~/.zshrc"
alias lzd="lazydocker"
alias lzg="lazygit"
alias rncls="rm -rf node_modules && rm -rf ios/Pods"
alias rni="ni && npx pod-install"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'

patchfont() {
	docker run --rm -v "$1":/in -v "$2":/out nerdfonts/patcher
}

# peco_move_to_project() {
# 	path=ls -ad ~/code/*/* | rg -v \.git | sed 1d | awk '{print $(NF)}' | peco
# 	cd $(path)
# }

# Starship
_evalcache starship init zsh

# fnm
_evalcache fnm env --use-on-cd

# MOTD
echo "Alpaca went crazy! (◕('人')◕)"
