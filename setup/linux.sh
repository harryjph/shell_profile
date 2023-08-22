#!/usr/bin/env bash
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" || exit
echo "source \$HOME/shell_profile/linux.sh" >> $HOME/.bashrc
echo "source \$HOME/shell_profile/linux.sh" >> $HOME/.bash_profile
echo "source \$HOME/shell_profile/linux.sh" >> $HOME/.zshrc
source basic.sh
