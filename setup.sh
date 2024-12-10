#!/bin/bash

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Install common packages
sudo apt install -y curl git vim zsh build-essential wget ripgrep fd-find stow

# Optional: Set Zsh as default shell
chsh -s $(which zsh)

# Install Oh My Zsh (optional)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Snap packages
# sudo snap install spotify

# Development tools
# sudo apt install -y golang-go 

# Configure development environment
# Git
git config --global user.name "Daniel Brandenburg"
git config --global user.email "brandendj@gmail.com"

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Windows setup
if grep -q "microsoft" /proc/version && grep -q "WSL2" /proc/sys/kernel/osrelease; then
    echo "Running on WSL2"

    # use windows credential helper
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"

    # install luarocks for nvim
    sudo apt install luarocks
else
    echo "Not running on WSL2"
fi

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

#fd-find
ln -s $(which fdfind) ~/.local/bin/fd

# eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

git clone https://github.com/eza-community/eza.git ~/.eza

# Cleanup
sudo apt autoremove -y

