# Source common settings
[ -f ~/.profile ] && source ~/.profile

eval "$(zoxide init --cmd cd bash)"

. C\:/Program\ Files/Git/mingw64/share/git/completion/git-completion.bash

source <(kubectl completion bash)

alias xopen='start'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PROMPT_COMMAND='history -a'
