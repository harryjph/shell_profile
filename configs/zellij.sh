alias z="zellij attach --create default"
if command -v zellij 2>&1 >/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
      eval "$(zellij setup --generate-completion zsh)"
  elif [ -n "$BASH_VERSION" ]; then
      eval "$(zellij setup --generate-completion bash)"
  fi
fi
