# Source common settings
[ -f ~/.profile ] && source ~/.profile

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

plugins=(git git-auto-fetch tmux)

source $ZSH/oh-my-zsh.sh

alias sl='sesh connect $(sesh list -c | fzf)  '
alias xopen='xdg-open'
alias xopen='xdg-open'

eval "$(zoxide init --cmd cd zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! "$PATH" == */home/dabr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/dabr/.fzf/bin"
fi

source <(fzf --zsh)

export FPATH="~/.eza/completions/zsh:$FPATH"

alias la='eza -al --git --color=always'
alias ls='eza -al --color=always --git --git-ignore --icons --sort=modified'
alias ld='eza -l --only-dirs'
alias lf='eza -l --only-files --color=always'
alias ln='eza -al --color=always --git --git-ignore --icons --sort=name'
alias lsd='eza -al --group-directories-first --color=always --git --git-ignore --icons --sort=name'
alias lsf='eza -al --group-directories-last --color=always --git --git-ignore --icons --sort=name'
