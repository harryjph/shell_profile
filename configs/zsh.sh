# Initialize p10k theme
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.config/zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.shell_profile/config_files/p10k.zsh

# General configuration
setopt correct # Autocorrect
setopt interactivecomments # Allow comments in terminal
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

# Basic key bindings
bindkey "^[[1;5C" forward-word # Control + Right arrow
bindkey "^[[1;5D" backward-word # Control + Left arrow
bindkey "^[[H"   beginning-of-line # Home
bindkey "^[[F"   end-of-line # End
bindkey "^[OH"   beginning-of-line # Home (When Zellij sometimes breaks input)
bindkey "^[OF"   end-of-line # End (When Zellij sometimes breaks input)
bindkey "^[[3~"  delete-char # Delete
bindkey "^R" history-incremental-search-backward # Control+R to search history
bindkey "^?" backward-delete-char # Sometimes this gets set to vi-backward-delete-char, this makes sure its not in vi- mode
bindkey \^U backward-kill-line # Control + U to delete from cursor position to the beginning of the line (Ctrl+K deletes to the end)

# Remove some characters from zsh's word characters so that ctrl+left/right doesn't skip over them
WORDCHARS=${WORDCHARS//[\;\/]}

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
