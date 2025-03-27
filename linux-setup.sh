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
sudo apt install -y git curl wget zsh neovim tmux build-essential htop fzf ripgrep rsync unzip

# Install Zsh plugins
echo "Installing Zsh plugins..."
sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions

# Install Zoxide (smart directory jumper)
echo "Installing Zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Set up Zsh as default shell
# echo "Setting Zsh as default shell..."
chsh -s $(which zsh)

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install ZI (Zsh plugin manager)
echo "Installing ZI..."
sh -c "$(curl -fsSL https://git.io/get-zi)"

# Install and configure firewall
echo "Setting up firewall..."
sudo apt install -y ufw
sudo ufw allow OpenSSH
sudo ufw enable

# Enable SSH service
echo "Enabling SSH..."
sudo systemctl enable --now ssh

# Clone dotfiles if exists
# echo "Cloning dotfiles..."
# DOTFILES_REPO="git@github.com:nidzola/dotfiles.git"
# if [ ! -d "$HOME/dotfiles" ]; then
#   git clone $DOTFILES_REPO $HOME/dotfiles
#   cd $HOME/dotfiles && ./install.sh
# fi

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
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.8
go install github.com/google/wire/cmd/wire@latest

# Install tfenv for managing Terraform versions
echo "Installing tfenv..."
rm -rf ~/.tfenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >>~/.zshrc

# Install a specific version of Terraform
$HOME/.tfenv/bin/tfenv install v1.6.2
$HOME/.tfenv/bin/tfenv use v1.6.2

# Install PostgreSQL and pgvector
echo "Installing PostgreSQL and pgvector..."
sudo apt install -y postgresql postgresql-client
sudo psql --version
sudo service postgresql status
sudo systemctl enable --now postgresql
sudo apt install postgresql-server-dev-17

rm -rf ~/pgvector
git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git ~/pgvector
cd ~/pgvector
make
sudo make install
cd ..
rm -rf ~/pgvector

# Install Redis
echo "Installing Redis..."
sudo apt install -y redis-server
sudo systemctl enable --now redis-server

# Install protobuf
echo "Installing protobuf..."
sudo apt install -y protobuf-compiler

# Install Google Cloud SDK
echo "Installing Google Cloud SDK..."
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
sudo apt update
sudo apt-get install -y google-cloud-sdk

echo "Other deps..."
curl https://sh.rustup.rs -sSf | sh
sudo apt install -y python3.12-venv

echo "Lazygit installation..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Clean up
echo "Cleaning up..."
sudo apt autoremove -y && sudo apt clean

# Dotfiles
echo "Dotfiles..."

cp -rf ~/projects/dotfiles/linux/nvim ~/.config
cp ~/projects/dotfiles/linux/.tmux.conf ~/
cp ~/projects/dotfiles/linux/.zshrc ~/
cp ~/projects/dotfiles/lazygit ~/.config

echo "Setup complete! Reboot recommended."
