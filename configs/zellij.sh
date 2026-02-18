# Aliases
alias z="zellij"
alias zd="zellij attach --create default"

# Initialise completions
# TODO disabled because it's slow and produces a warning on ZSH startup :(
#if command -v zellij 2>&1 >/dev/null; then
#  if [ -n "$ZSH_VERSION" ]; then
#      eval "$(zellij setup --generate-completion zsh)"
#  elif [ -n "$BASH_VERSION" ]; then
#      eval "$(zellij setup --generate-completion bash)"
#  fi
#fi
