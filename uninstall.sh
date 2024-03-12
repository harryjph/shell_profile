#!/usr/bin/env bash
cd $HOME

# Remove source instructions from RC files
sed -i '/source $HOME\/.shell_profile\/initialize.sh/d' ~/.zshrc
sed -i '/source $HOME\/.shell_profile\/initialize.sh/d' ~/.bashrc
sed -i '/source $HOME\/.shell_profile\/initialize.sh/d' ~/.bash_profile

# Remove ZSH plugins
rm -rf .config/zsh_plugins
rm -rf .cache/zsh

# Remove tmux configuration
rm -rf .config/tmux
rm .tmux

# Remove Git configuration
rm .config/git/config

# Remove Alacritty Configuration
rm -rf .config/alacritty

echo "Uninstalled."
