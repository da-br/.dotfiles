export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

plugins=(git git-auto-fetch tmux)

source $ZSH/oh-my-zsh.sh

alias sdn='shutdown -f now'
alias rsn='shutdown -rf now'
alias sl='sesh connect $(sesh list -c | fzf)  '
alias lg='lazygit'

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
