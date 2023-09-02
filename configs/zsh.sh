# Initialize p10k theme
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.config/zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.shell_profile/config_files/p10k.zsh

# General configuration
setopt correct # Autocorrect
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Coloured completion
zstyle ':completion:*' rehash true # Automatically find new executables in $PATH
zstyle ':completion:*' menu select # Highlight completion menu selection

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# Configure History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
alias histload="fc -RI"
alias loadhist="histload"

# Move left/right using control + arrow key
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Initialize Plugins
autoload -U compinit colors zcalc
compinit -d
colors
source ~/.config/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh_plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bind arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
