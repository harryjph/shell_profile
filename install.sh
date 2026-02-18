#!/usr/bin/env bash
cd $HOME

# Uninstall first, just to avoid installing twice
./.shell_profile/uninstall.sh 2>/dev/null

# Add source instructions to RC files
echo "source \$HOME/.shell_profile/initialize.sh" >> .bashrc
echo "source \$HOME/.shell_profile/initialize.sh" >> .bash_profile
echo "source \$HOME/.shell_profile/initialize.sh" >> .zshrc
echo "setopt norcs" >> .zlogout # Prevent screen clear when logging out of SSH sessions

# Install ZSH plugins
mkdir -p .config/zsh_plugins
mkdir -p .cache/zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git .config/zsh_plugins/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git .config/zsh_plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git .config/zsh_plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search.git .config/zsh_plugins/zsh-history-substring-search

# Install Git configuration
mkdir -p .config/git
ln -s ~/.shell_profile/config_files/gitconfig .config/git/config

# Install Alacritty Configuration
mkdir -p .config/alacritty
ln -s ~/.shell_profile/config_files/alacritty.toml .config/alacritty/alacritty.toml

# Install Ghostty Configuration
mkdir -p .config/ghostty
ln -s ~/.shell_profile/config_files/ghostty .config/ghostty/config

# Install Micro Configuration
mkdir -p .config/micro
ln -s ~/.shell_profile/config_files/micro.json .config/micro/settings.json

# Install Zellij Configuration
mkdir -p .config/zellij
ln -s ~/.shell_profile/config_files/zellij/config.kdl .config/zellij/config.kdl

echo "Installed!"
