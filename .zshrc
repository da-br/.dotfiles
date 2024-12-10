# Source common settings
[ -f ~/.profile ] && source ~/.profile

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

plugins=(git git-auto-fetch tmux)

source $ZSH/oh-my-zsh.sh

alias sl='sesh connect $(sesh list -c | fzf)  '
alias xopen='xdg-open'

eval "$(zoxide init --cmd cd zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! "$PATH" == */home/dabr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/dabr/.fzf/bin"
fi

source <(fzf --zsh)

export FPATH="~/.eza/completions/zsh:$FPATH"

ld='eza -l --only-dirs'
lf='eza -l --only-files --color=always'
ls='eza -alF --color=always --git --icons --sort=modified'
ln='eza -alF --color=always --git --icons --sort=name'
