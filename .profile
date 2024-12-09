# Set default editor
export EDITOR=nvim

# Path exports
export PATH=$PATH:$HOME/.local/bin
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export JAVA_HOME=/usr/lib/jvm/default-java
export PATH=$PATH:$JAVA_HOME/bin
export ANDROID_HOME=$HOME/AndroidSdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/.go
export GOBIN=$HOME/.go/bin
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.zig/zig:$PATH"

# ripgrep alias
case "$(uname -s)" in
  Linux*)
    # Aliases for Linux
    alias sdn='shutdown -h now'
    alias rsn="shutdown -rf now"
    alias e='xdg-open'
    ;;
  
  Darwin*)
    # Aliases for macOS
    alias sdn='sudo shutdown -h now'
    alias e='open'
    alias rg="rg --path-separator '/'"
    ;;

  CYGWIN*|MINGW*|MSYS*)
    # Aliases for Windows (Git Bash/WSL)
    alias sdn='shutdown -f -s -t 0'
    alias rsn='shutdown -f -r -t 0'
    alias e='explorer'
    alias rg="rg.exe --path-separator '//'"
    ;;
esac

# Aliases
alias lg='lazygit'
alias ppp='echo "$PATH" | tr ":" "\n"'

# Custom functions
ff() {
  local selected_file
  selected_file=$(fd --type f --hidden --exclude .git | fzf)
  [[ -n "$selected_file" ]] && nvim "$selected_file"
}

ffd() {
  local selected_file
  selected_file=$(fd --type d --hidden --exclude .git | fzf)
  [[ -n "$selected_file" ]] && cd "$selected_file"
}

fcd() {
  local dir
  dir=$(fd --type d --hidden --exclude .git . | fzf --height 40% --reverse --preview 'ls -1 {}') || return
  cd "$dir" || return
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
      -c) copy_to_clipboard=true ;;
      *) file=$1 ;;
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
  echo "$full_path"

  # Copy to clipboard if -c option is provided
  if $copy_to_clipboard; then
    echo -n "$full_path" | win32yank -i
  fi
}


