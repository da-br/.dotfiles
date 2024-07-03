export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-auto-fetch tmux)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

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

e() {
	# Check if the file argument is provided
	if [[ -z $1 ]]; then
        if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
            dolphin .
            return 0
        fi
        explorer .
        return 0
	fi
    
    if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        dolphin $1
        return 0
    fi
    explorer $1
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
