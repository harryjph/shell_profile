FROM fedora

# BARE MINIMUM: Required to get zellij web / shell profile up and running
RUN dnf install -y git zsh openssl hostname socat
RUN chsh -s /usr/bin/zsh

# Nice to have
RUN dnf install -y ps lsof ss

# Antigravity
RUN curl -fsSL https://antigravity.google/cli/install.sh | bash
