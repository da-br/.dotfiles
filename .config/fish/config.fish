if status is-interactive
    nvm install latest
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    fastfetch
end

# Aliases
alias cat="bat"
alias ls="eza --group-directories-last --all --long --header --no-user --git --icons"
alias ld="eza --only-dirs --long --header --no-user --total-size --git-repos --icons"
alias ff="fd"
alias ffd="fd -t d"
alias gff="git fuzzy pick"

alias ppp='echo $PATH | tr " " "\n"'
alias sdn='systemctl poweroff'
alias rsn='systemctl reboot'

alias e='xdg-open'

alias gui='lazygit'
alias dui='lazydocker'
alias sui='lazysql'


# Initialize Oh My Zsh plugins in Fish equivalent
function fish_user_key_bindings
    fzf_key_bindings
    fish_vi_key_bindings insert --no-erase
end

# Load custom functions (if you have any)
if test -d $HOME/.config/fish/functions
    for file in $HOME/.config/fish/functions/*.fish
        source $file
    end
end


set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux PAGER less
set -Ux TERMINAL wezterm

set -Ux GOROOT /usr/local/go
set -Ux GOPATH $HOME/.go
set -Ux GOBIN $HOME/.go/bin
set -Ux DOTNET_ROOT $HOME/.dotnet
set -Ux JAVA_HOME /usr/lib/jvm/default-java
set -Ux BUN_INSTALL $HOME/.bun

# Path exports
fish_add_path $HOME/.local/bin
fish_add_path $DOTNET_ROOT
fish_add_path $DOTNET_ROOT/tools
fish_add_path $GOPATH/bin 
fish_add_path $GOROOT/bin
fish_add_path $JAVA_HOME/bin
fish_add_path /opt/nvim-linux64/bin
fish_add_path $HOME/.zig/zig
fish_add_path $HOME/.tools/bin
fish_add_path $BUN_INSTALL/bin

# Source zoxide (autojump replacement)
zoxide init fish --cmd cd | source

starship init fish | source

# fzf key bindings (equivalent to `source (fzf --fish)`)
fzf --fish | source

