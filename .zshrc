# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# use case-sensitive completion.
CASE_SENSITIVE="true"

# change how often to auto-update (in days).
zstyle ':omz:update' frequency 5

ZVM_INIT_MODE=sourcing

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


bindkey "\e\eOD" backward-word
bindkey "\e\eOC" forward-word

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@13/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@13/include"
export EDITOR=nvim

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

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOPRIVATE=github.com/transcarent
export GOROOT=/opt/homebrew/Cellar/go/1.23.4/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"
export PATH="/Users/nikola/.local/bin:$PATH"
export PATH=$PATH:/Users/nikola/projects/bin
export XDG_CONFIG_HOME="$HOME/.config"

complete -o nospace -C /opt/homebrew/Cellar/tfenv/3.0.0/versions/1.1.7/terraform terraform
export GOOGLE_APPLICATION_CREDENTIALS=/Users/nikola/.gcp/dev-gcp.json
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"
eval "$(luarocks path --bin)"

# vi-mode
bindkey -v

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
KEYTIMEOUT=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

