# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# use case-sensitive completion.
CASE_SENSITIVE="true"

zstyle ':omz:update' frequency 5

ZVM_INIT_MODE=sourcing

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

plugins=(git)

export LANG=en_US.UTF-8
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export EDITOR=nvim
export GOPATH=$HOME/go
export GOPRIVATE=github.com/transcarent/*
export PATH=$PATH:$GOPATH/bin
export PATH="/home/nidzola/projects/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

alias y='yazi'
alias gs='git status'
alias gdb='git branch -D $1'
alias gcob='git checkout $1'
alias gcom='git checkout main'
alias gpm='git pull origin main'
alias v='nvim $1'
alias vc='nvim ~/.config/nvim'
alias vzsh='nvim ~/.zshrc'
alias ll="eza --long --color=always --icons=always"
alias ls="eza --long --color=always --icons=always"
alias l="eza --long --color=always --icons=always"
alias cat="bat"
alias z="zi"

# vi-mode
bindkey -v

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | wl-copy
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
KEYTIMEOUT=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"
eval "$(keychain --eval --quiet id_ed25519 id_transcarent)"

source $ZSH/oh-my-zsh.sh
# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
