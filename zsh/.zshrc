# !/usr/bin/env zsh

source "$HOME/d/dotfiles/zsh/base16-onedark.sh" # Load FZF theme

# Plugins
source "$HOME/d/dotfiles/zsh/fzf-tab/fzf-tab.plugin.zsh"
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fpath=("$HOMEBREW_PREFIX/share/zsh-completions" $fpath)
source <(fzf --zsh)

# Global variables
export EDITOR=nvim
export GIT_EDITOR="$EDITOR"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HISTFILE=~/.zsh_history
export SAVEHIST=10000000
export BAT_THEME="base16"

# https://github.com/zed-industries/zed/issues/8101#issuecomment-1956653962
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export CMAKE_PREFIX_PATH="/opt/homebrew/opt/llvm"


# Android SDK
if [[ $(uname) == "Darwin" ]]; then
	export ANDROID_HOME="$HOME/Library/Android/sdk"
else
	export ANDROID_HOME="$HOME/Android/sdk"
fi

path=(
	${ANDROID_HOME}/emulator/
	${ANDROID_HOME}/platform-tools/
	/opt/homebrew/opt/libpq/bin # postgres client
	/opt/homebrew/opt/llvm/bin
	./node_modules/.bin
	${HOME}/.local/bin
	${HOME}/Odin
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
source <(mise completion zsh)

# Activate
eval "$(starship init zsh)" # Load starship
eval "$(mise activate zsh)" # Load mise

# MOTD
echo "Alpaca went crazy! (◕('人')◕)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/olrtg/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/olrtg/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/olrtg/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/olrtg/google-cloud-sdk/completion.zsh.inc'; fi

# Machine-local secrets and overrides (untracked)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
