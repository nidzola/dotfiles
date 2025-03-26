#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Update and upgrade system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install XFCE minimal
echo "Installing XFCE minimal..."
sudo apt install -y xfce4 xfce4-terminal lightdm

# Enable lightdm service
echo "Enabling LightDM..."
sudo systemctl enable lightdm

# Install essential packages
echo "Installing essential packages..."
sudo apt install -y git curl wget zsh neovim tmux build-essential htop fzf ripgrep

# Set up Zsh as default shell
echo "Setting Zsh as default shell..."
chsh -s $(which zsh)

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install and configure firewall
echo "Setting up firewall..."
sudo apt install -y ufw
sudo ufw allow OpenSSH
sudo ufw enable

# Enable SSH service
echo "Enabling SSH..."
sudo systemctl enable --now ssh

# Clone dotfiles if exists
echo "Cloning dotfiles..."
DOTFILES_REPO="git@github.com:yourusername/dotfiles.git"
if [ ! -d "$HOME/dotfiles" ]; then
  git clone $DOTFILES_REPO $HOME/dotfiles
  cd $HOME/dotfiles && ./install.sh
fi

# Install Tailscale
echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh
sudo systemctl enable --now tailscaled

# Install socat (for remote port forwarding)
echo "Installing socat..."
sudo apt install -y socat

# Install Node.js & npm
echo "Installing Node.js and npm..."
sudo apt install -y nodejs npm

# Install Go
echo "Installing Go..."
sudo apt install -y golang-go

# Install Go tools
echo "Installing Go tools..."
go install github.com/vektra/mockery/v2@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/google/wire/cmd/wire@latest

# Install env tools
echo "Installing efenv..."
git clone https://github.com/efenv/efenv.git $HOME/.efenv && cd $HOME/.efenv && make install

# Install PostgreSQL and pgvector
echo "Installing PostgreSQL and pgvector..."
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable --now postgresql
sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS vector;"

# Install Redis
echo "Installing Redis..."
sudo apt install -y redis-server
sudo systemctl enable --now redis

# Install protobuf
echo "Installing protobuf..."
sudo apt install -y protobuf-compiler

# Install Google Cloud SDK
echo "Installing Google Cloud SDK..."
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt update && sudo apt install -y google-cloud-sdk

# Clean up
echo "Cleaning up..."
sudo apt autoremove -y && sudo apt clean

echo "Setup complete! Reboot recommended."
