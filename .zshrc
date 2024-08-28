# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

# Zsh options
CASE_SENSITIVE="true"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# Language and editor settings
export LANG=en_US.UTF-8
export EDITOR=nvim

# Key bindings
bindkey "\e\eOD" backward-word
bindkey "\e\eOC" forward-word

# Homebrew configuration
eval "$(/opt/homebrew/bin/brew shellenv)"

# PostgreSQL configuration
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@13/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@13/include"

# Aliases
alias y='yazi'
alias gs='git status'
alias gdb='git branch -D $1'
alias gcob='git checkout $1'
alias gcom='git checkout main'
alias gpm='git pull origin main'
alias v='nvim $1'
alias vc='nvim ~/.config/nvim'
alias vzsh='nvim ~/.zshrc'
alias ll="eza -l"
alias ls="eza"
alias cat="bat"
alias z="zi"

# Go configuration
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOPRIVATE=github.com/transcarent
export GOROOT=/opt/homebrew/Cellar/go/1.22.6/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Path configuration
export PATH="/Users/nikola/.local/bin:$PATH"
export PATH=$PATH:/Users/nikola/projects/bin

# Terraform configuration
complete -o nospace -C /opt/homebrew/Cellar/tfenv/3.0.0/versions/1.1.7/terraform terraform

# Google Cloud configuration
export GOOGLE_APPLICATION_CREDENTIALS=/Users/nikola/.gcp/dev-gcp.json

# Zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

# Vi-mode
bindkey -v
KEYTIMEOUT=1

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
