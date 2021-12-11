# Plugins {{{
# ==============================================================================

# Load the Antibody plugin manager for zsh.
source <(antibody init)

# Setup required env var for oh-my-zsh plugins
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

antibody bundle robbyrussell/oh-my-zsh
# antibody bundle robbyrussell/oh-my-zsh path:plugins/adb
# antibody bundle robbyrussell/oh-my-zsh path:plugins/bower
antibody bundle robbyrussell/oh-my-zsh path:plugins/cp
antibody bundle robbyrussell/oh-my-zsh path:plugins/dnf
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker-compose
antibody bundle robbyrussell/oh-my-zsh path:plugins/git
antibody bundle robbyrussell/oh-my-zsh path:plugins/git-flow
# antibody bundle robbyrussell/oh-my-zsh path:plugins/gpg-agent
# antibody bundle robbyrussell/oh-my-zsh path:plugins/gulp
# antibody bundle robbyrussell/oh-my-zsh path:plugins/httpie
antibody bundle robbyrussell/oh-my-zsh path:plugins/jsontools
antibody bundle robbyrussell/oh-my-zsh path:plugins/jump
antibody bundle robbyrussell/oh-my-zsh path:plugins/nmap
antibody bundle robbyrussell/oh-my-zsh path:plugins/npm
# antibody bundle robbyrussell/oh-my-zsh path:plugins/pass
antibody bundle robbyrussell/oh-my-zsh path:plugins/rsync
# antibody bundle robbyrussell/oh-my-zsh path:plugins/ssh-agent
antibody bundle robbyrussell/oh-my-zsh path:plugins/tmux
antibody bundle robbyrussell/oh-my-zsh path:plugins/z

# Other bundles
# antibody bundle sampson-chen/sack
antibody bundle zsh-users/zsh-autosuggestions

# This needs to be the last bundle.
antibody bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antibody bundle spaceship-prompt/spaceship-prompt

# }}}

# Configuration {{{
# ==============================================================================

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
SPACESHIP_VI_MODE_SHOW=false

typeset -U path cdpath fpath

# Vim mode
bindkey -v
export KEYTIMEOUT=1

export ANDROID_HOME="$HOME/Android/Sdk/"

export GIT_EDITOR=vim

path=(
    $HOME/.local/bin
    $HOME/.bin
    $HOME/bin
    $HOME/.composer/vendor/bin
    $HOME/.go/bin
    ./vendor/bin
    ${ANDROID_HOME}tools/
    ${ANDROID_HOME}platform-tools/
    $path
)

setopt auto_cd
cdpath=(
    $HOME/Code
)

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %d
zstyle ':completion:*:descriptions' format %B%d%b
zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
    'local-directories named-directories'

export EDITOR='vim'
export NVIM_LISTEN_ADDRESS='/tmp/nvimsocket'
export ARTISAN_OPEN_ON_MAKE_EDITOR='nvr'
export FZF_DEFAULT_COMMAND='ag -u -g ""'

unsetopt sharehistory

# }}}

# Aliases & Functions {{{
# ==============================================================================

# General
alias vim="nvim"
alias cls="clear"

# Open vim with z argument
v() {
    if [ -n "$1" ]; then
        z $1
    fi

    nvim
}

# }}}

# vim: set nospell foldmethod=marker foldlevel=0:

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
