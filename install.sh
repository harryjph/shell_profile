#!/usr/bin/env bash
cd $HOME

# Uninstall first, just to avoid installing twice
./.shell_profile/uninstall.sh 2>/dev/null

# Add source instructions to RC files
echo "source \$HOME/.shell_profile/initialize.sh" >> .bashrc
echo "source \$HOME/.shell_profile/initialize.sh" >> .bash_profile
echo "source \$HOME/.shell_profile/initialize.sh" >> .zshrc

# Install ZSH plugins
mkdir -p .config/zsh_plugins
mkdir -p .cache/zsh
git clone https://github.com/romkatv/powerlevel10k.git .config/zsh_plugins/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git .config/zsh_plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .config/zsh_plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git .config/zsh_plugins/zsh-history-substring-search

# Install Git configuration
mkdir -p .config/git
ln -s ~/.shell_profile/config_files/gitconfig .config/git/config

# Install Alacritty Configuration
mkdir -p .config/alacritty
ln -s ~/.shell_profile/config_files/alacritty.toml .config/alacritty/alacritty.toml

# Install Micro Configuration
mkdir -p .config/micro
ln -s ~/.shell_profile/config_files/micro.json .config/micro/settings.json

# Install Zellij Configuration
mkdir -p .config/zellij
ln -s ~/.shell_profile/config_files/zellij.kdl .config/zellij/config.kdl

echo "Installed!"
