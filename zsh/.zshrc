# Antibody
source <(antibody init)

# Plugins
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh" # setup required env var for oh-my-zsh plugins
export ZSH

antibody bundle robbyrussell/oh-my-zsh
antibody bundle robbyrussell/oh-my-zsh path:plugins/brew
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker-compose
antibody bundle robbyrussell/oh-my-zsh path:plugins/fzf
antibody bundle robbyrussell/oh-my-zsh path:plugins/git
antibody bundle robbyrussell/oh-my-zsh path:plugins/ionic
antibody bundle robbyrussell/oh-my-zsh path:plugins/ng
antibody bundle robbyrussell/oh-my-zsh path:plugins/npm
antibody bundle robbyrussell/oh-my-zsh path:plugins/react-native
antibody bundle robbyrussell/oh-my-zsh path:plugins/tmux
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-syntax-highlighting # this needs to be the last module

# Configuration
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

export ANDROID_HOME="$HOME/Library/Android/sdk"
export EDITOR=lvim
export GIT_EDITOR="$EDITOR"

# FZF Nord
export FZF_DEFAULT_OPTS="
--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
"

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
alias cd="z"
alias cls="clear"
alias ls="exa --oneline --color=always --icons --header --git --long --no-permissions --no-user"
alias rs="source ~/.zshrc"

alias lzd="lazydocker"
alias lzg="lazygit"

alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias rncls="rm -rf node_modules && rm -rf ios/Pods"
alias rni="ni && npx pod-install"
alias nc='npm-check -u'

alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'

patchfont() {
	# Patch a normal font with nerdfont
	# USAGE: patchfont <input_folder_path> <output_folder_path>
	docker run --rm -v "$1":/in -v "$2":/out nerdfonts/patcher
}

docker_connect() {
	# Spawn a bash session inside a running container
	# USAGE: docker_connect <container_name>
	docker container exec -it "$1" /bin/bash
}

cd_to_projects() {
	# repo_path=$(find ~/code -name .git -type d -prune -maxdepth 3 | sed 's/\/.git$//' | sort | fzf $filter_params --select-1)
	cd $(find ~/code -typed d -maxdepth 1 | sort | fzf)
}

# Keybinds
zle -N cd_to_projects # creating widget before
bindkey "^P" cd_to_projects

# Starship
eval "$(starship init zsh)"

# fnm
eval "$(fnm env --use-on-cd)"

# zoxide
eval "$(zoxide init zsh)"

# MOTD
echo "Alpaca went crazy! (◕('人')◕)"
