# ZSH_THEME="robbyrussell"
ZSH_THEME=""

# vim mapping
bindkey -v
export KEYTIMEOUT=1
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# ENABLE_CORRECTION="true"

alias sdn='shutdown -f now'
alias rsn='shutdown -rf now'
alias rgw='rg --path-separator //'
alias rgf='rg --files'
alias sl='sesh connect $(sesh list -c | fzf)  '
alias lg='lazygit'
alias xopen='xdg-open'

load_secrets() {
    local encrypted_file="$HOME/.secrets/.env.gpg"
    local decrypted_file="$HOME/.secrets/.env"

    # Decrypt the file
    gpg --decrypt "$encrypted_file" > "$decrypted_file"
    if [ $? -ne 0 ]; then
        echo "Failed to decrypt the file"
        return 1
    fi

    # Source the decrypted file
    if [ -f "$decrypted_file" ]; then
        source "$decrypted_file"
        echo "Environment variables loaded successfully"
    else
        echo "Decrypted file not found"
        return 1
    fi

    # Remove the decrypted file
    rm "$decrypted_file"

}

ff() {
  local selected_file
  selected_file=$(fd --type f --hidden --exclude .git | fzf)
  if [[ -n "$selected_file" ]]; then
    nvim "$selected_file"
  fi
}

ffd() {
  local selected_file
  selected_file=$(fd --type d --hidden --exclude .git | fzf)
  if [[ -n "$selected_file" ]]; then
    cd "$selected_file"
  fi
}

gfp() {
	# Check if the file argument is provided
	if [[ -z $1 ]]; then
		echo "Usage: get_full_path [-c] <file>"
		return 1
	fi

	# Initialize variables
	copy_to_clipboard=false
	file=""

	# Parse arguments
	while [[ "$1" != "" ]]; do
		case $1 in
		-c)
			copy_to_clipboard=true
			;;
		*)
			file=$1
			;;
		esac
		shift
	done

	# Check if file exists
	if [[ ! -e $file ]]; then
		echo "File does not exist."
		return 1
	fi

	# Get the full path of the file
	full_path=$(realpath "$file")
	echo $full_path

	# Copy to clipboard if -c option is provided
	if $copy_to_clipboard; then
		echo -n $full_path | win32yank -i
	fi
}

spf() {
    os=$(uname -s)

    # Linux
    if [[ "$os" == "Linux" ]]; then
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    fi

    # macOS
    if [[ "$os" == "Darwin" ]]; then
        export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
    fi

    command spf "$@"

    [ ! -f "$SPF_LAST_DIR" ] || {
        . "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" > /dev/null
    }
}

cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

export EDITOR=nvim

# Path Exorts
export PATH=$PATH:$HOME/.local/bin

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

export JAVA_HOME=/usr/lib/jvm/default-java
export PATH=$PATH:$JAVA_HOME/bin

export ANDROID_HOME=$HOME/AndroidSdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

eval "$(zoxide init --cmd cd zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! "$PATH" == */home/dabr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/dabr/.fzf/bin"
fi

source <(fzf --zsh)
