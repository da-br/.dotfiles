eval "$(starship init zsh)"

# Source common settings
[ -f ~/.profile ] && source ~/.profile

# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# source $ZSH/oh-my-zsh.sh

unsetopt correct_all
ENABLE_CORRECTION="false"

plugins=(git git-auto-fetch)

alias xopen='xdg-open'

eval "$(zoxide init --cmd cd zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! "$PATH" == */home/dabr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/dabr/.fzf/bin"
fi

source <(fzf --zsh)

export FPATH="~/.eza/completions/zsh:$FPATH"

alias ls='eza -al --color=always --git --git-ignore --icons --sort=modified'
alias lsa='eza -al --git --color=always'
alias lsn='eza -al --color=always --git --git-ignore --icons --sort=name'
alias lsd='eza -al --group-directories-first --color=always --git --git-ignore --icons --sort=name'
alias lsf='eza -al --group-directories-last --color=always --git --git-ignore --icons --sort=name'

# bun completions
[ -s "/home/dabr/.bun/_bun" ] && source "/home/dabr/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
