#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install XFCE minimal
echo "Installing XFCE minimal..."
sudo pacman -S --noconfirm xfce4 xfce4-terminal lightdm lightdm-gtk-greeter

# Enable lightdm service
echo "Enabling LightDM..."
sudo systemctl enable lightdm

# Install essential packages
echo "Installing essential packages..."
sudo pacman -S --noconfirm git curl wget zsh neovim tmux base-devel htop fzf ripgrep rsync unzip yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick

# Install Zsh plugins
echo "Installing Zsh plugins..."
sudo pacman -S --noconfirm zsh-syntax-highlighting zsh-autosuggestions

# Set up Zsh as default shell
echo "Setting Zsh as default shell..."
chsh -s "$(which zsh)"

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
sudo pacman -S --noconfirm ufw
sudo ufw allow OpenSSH
sudo ufw enable

# Enable SSH service
echo "Enabling SSH..."
sudo systemctl enable --now sshd

# Install Tailscale
echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh
sudo systemctl enable --now tailscaled

# Install socat (for remote port forwarding)
echo "Installing socat..."
sudo pacman -S --noconfirm socat

# Install Node.js & npm
echo "Installing Node.js and npm..."
sudo pacman -S --noconfirm nodejs npm

# Install Go
echo "Installing Go..."
sudo pacman -S --noconfirm go

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
"$HOME/.tfenv/bin/tfenv" install v1.6.2
"$HOME/.tfenv/bin/tfenv" use v1.6.2

# Install PostgreSQL and pgvector
echo "Installing PostgreSQL and pgvector..."
sudo pacman -S --noconfirm postgresql postgresql-libs
sudo systemctl enable --now postgresql

rm -rf ~/pgvector
git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git ~/pgvector
cd ~/pgvector
make
sudo make install
cd ..
rm -rf ~/pgvector

# Install Redis
echo "Installing Redis..."
sudo pacman -S --noconfirm redis
sudo systemctl enable --now redis

# Install protobuf
echo "Installing protobuf..."
sudo pacman -S --noconfirm protobuf

# Install Google Cloud SDK
echo "Installing Google Cloud SDK..."
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo pacman-key --add -
sudo pacman -S --noconfirm google-cloud-sdk

echo "Other deps..."
curl https://sh.rustup.rs -sSf | sh
sudo pacman -S --noconfirm python-virtualenv

echo "Lazygit installation..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Clean up
echo "Cleaning up..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm || true

# Dotfiles
echo "Dotfiles..."
cp -rf ~/projects/dotfiles/linux/nvim ~/.config
cp ~/projects/dotfiles/linux/.tmux.conf ~/
cp ~/projects/dotfiles/linux/.zshrc ~/
cp ~/projects/dotfiles/lazygit ~/.config

echo "Setup complete! Reboot recommended."
