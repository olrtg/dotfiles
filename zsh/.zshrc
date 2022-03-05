# Plugins

source <(antibody init) # load antibody

export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh" # setup required env var for oh-my-zsh plugins

antibody bundle robbyrussell/oh-my-zsh
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker-compose
antibody bundle robbyrussell/oh-my-zsh path:plugins/git
antibody bundle robbyrussell/oh-my-zsh path:plugins/ionic
antibody bundle robbyrussell/oh-my-zsh path:plugins/npm
antibody bundle robbyrussell/oh-my-zsh path:plugins/ng
antibody bundle robbyrussell/oh-my-zsh path:plugins/vscode
antibody bundle robbyrussell/oh-my-zsh path:plugins/z
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-syntax-highlighting # this needs to be the last module

# Configuration
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

# Aliases & Functions
alias v="$EDITOR"
alias vim="$EDITOR"
alias cls="clear"
alias ls="ls -lah"
alias rs="source ~/.zshrc"
alias lg="lazygit"

# Starship
eval "$(starship init zsh)"

# fnm
eval "$(fnm env --use-on-cd)"

# MOTD
echo "Alpaca went crazy! (◕('人')◕)"
