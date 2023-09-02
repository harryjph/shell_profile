#!/usr/bin/env bash
cd $HOME

# Uninstall first, just to avoid installing twice
./.shell_profile/uninstall.sh 2>/dev/null

# Add source instructions to RC files
echo "source \$HOME/.shell_profile/initialize.sh" >> .bashrc
echo "source \$HOME/.shell_profile/initialize.sh" >> .bash_profile
echo "source \$HOME/.shell_profile/initialize.sh" >> .zshrc

# Install ZSH configuration
mkdir -p .config/zsh_plugins
git clone https://github.com/romkatv/powerlevel10k.git .config/zsh_plugins/powerlevel10k

# Install tmux configuration
mkdir -p .config/tmux/plugins
ln -s ~/.config/tmux .tmux
git clone https://github.com/tmux-plugins/tpm.git .config/tmux/plugins/tpm
ln -s ~/.shell_profile/config_files/tmux.conf .config/tmux/tmux.conf

# Install Git configuration
mkdir -p .config/git
ln -s ~/.shell_profile/config_files/gitconfig .config/git/config

echo "Installed!"
