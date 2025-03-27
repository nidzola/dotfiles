# Makefile

.PHONY: all enable-services update-system install-packages setup-git setup-zsh setup-firewall \
        install-tailscale install-node install-go install-tfenv install-postgresql \
        install-redis install-protobuf install-gcloud install-rust install-lazygit \
        cleanup copy-dotfiles

all: enable-services update-system install-packages setup-git setup-zsh setup-firewall \
     install-tailscale install-node install-go install-tfenv install-postgresql \
     install-redis install-protobuf install-gcloud install-rust install-lazygit \
     cleanup copy-dotfiles
	@echo "Setup complete! Reboot recommended."

enable-services:
	@echo "Enabling services..."
	sudo systemctl enable --now bluetooth
	sudo systemctl enable --now sshd

update-system:
	@echo "Updating system..."
	sudo pacman -Syu --noconfirm

setup-git:
  git.config --global user.name "Nikola Zivkovic"
  git.config --global user.email "x-nikola.zivkovic@transcarent.ai"

install-packages:
	@echo "Installing essential packages..."
	sudo pacman -S --noconfirm git curl wget zsh neovim tmux base-devel htop fzf ripgrep rsync unzip yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick

setup-zsh:
	@echo "Setting up Zsh..."
	sudo pacman -S --noconfirm zsh-syntax-highlighting zsh-autosuggestions
	chsh -s "$(which zsh)"
	@if [ ! -d "$$HOME/.oh-my-zsh" ]; then \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	fi
	sh -c "$$(curl -fsSL https://git.io/get-zi)"

setup-firewall:
	@echo "Setting up firewall..."
	sudo pacman -S --noconfirm ufw
	sudo ufw allow OpenSSH
	sudo ufw enable

install-tailscale:
	@echo "Installing Tailscale..."
	curl -fsSL https://tailscale.com/install.sh | sh
	sudo systemctl enable --now tailscaled

install-node:
	@echo "Installing Node.js and npm..."
	sudo pacman -S --noconfirm nodejs npm

install-go:
	@echo "Installing Go..."
	sudo pacman -S --noconfirm go
	@echo "Installing Go tools..."
	go install github.com/vektra/mockery/v2@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.8
	go install github.com/google/wire/cmd/wire@latest

install-tfenv:
	@echo "Installing tfenv..."
	rm -rf $$HOME/.tfenv
	git clone https://github.com/tfutils/tfenv.git $$HOME/.tfenv
	echo 'export PATH="$$HOME/.tfenv/bin:$$PATH"' >> $$HOME/.zshrc
	$$HOME/.tfenv/bin/tfenv install v1.6.2
	$$HOME/.tfenv/bin/tfenv use v1.6.2

install-postgresql:
	@echo "Installing PostgreSQL and pgvector..."
	sudo pacman -S --noconfirm postgresql postgresql-libs
	sudo systemctl enable --now postgresql
	rm -rf $$HOME/pgvector
	git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git $$HOME/pgvector
	cd $$HOME/pgvector && make && sudo make install
	rm -rf $$HOME/pgvector

install-redis:
	@echo "Installing Redis..."
	sudo pacman -S --noconfirm redis
	sudo systemctl enable --now redis

install-protobuf:
	@echo "Installing protobuf..."
	sudo pacman -S --noconfirm protobuf

install-gcloud:
	@echo "Installing Google Cloud SDK..."
	curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo pacman-key --add -
	sudo pacman -S --noconfirm google-cloud-sdk

install-rust:
	@echo "Installing Rust..."
	curl https://sh.rustup.rs -sSf | sh
	sudo pacman -S --noconfirm python-virtualenv

install-lazygit:
	@echo "Installing Lazygit..."
	LAZYGIT_VERSION=$$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v$${LAZYGIT_VERSION}/lazygit_$${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit -D -t /usr/local/bin/

cleanup:
	@echo "Cleaning up..."
	sudo pacman -Rns $$(pacman -Qdtq) --noconfirm || true

copy-dotfiles:
	@echo "Copying dotfiles..."
	cp -rf $$HOME/projects/dotfiles/linux/nvim $$HOME/.config
	cp $$HOME/projects/dotfiles/linux/.tmux.conf $$HOME/
	cp $$HOME/projects/dotfiles/linux/.zshrc $$HOME/
	cp $$HOME/projects/dotfiles/lazygit $$HOME/.config
