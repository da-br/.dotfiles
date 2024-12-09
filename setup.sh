#!/bin/bash

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Install common packages
sudo apt install -y curl git vim zsh build-essential wget ripgrep zoxide fd-find stow fzf

# Optional: Set Zsh as default shell
chsh -s $(which zsh)

# Install Oh My Zsh (optional)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Snap packages
# sudo snap install spotify

# Development tools
# sudo apt install -y golang-go 

# Configure development environment
# Example: Git config
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

# Cleanup
sudo apt autoremove -y

