# Initialize Plugins
source ~/.config/zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme

# Configure History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# Initialize p10k theme
source ~/.shell_profile/config_files/p10k.zsh
