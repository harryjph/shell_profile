#!/usr/bin/env bash
alias sb="sandbox"
alias sbagy="sandbox agy --dangerously-skip-permissions"
alias sboc="sandbox opencode --standalone --auto"

# Reset all vars
unset $(env | grep SANDBOX | cut -d '=' -f1 | tr '\n' ' ')

# Basic sandbox config
export SANDBOX_IMAGE="fedora"
export SANDBOX_ENV="HOME:PATH:LD_LIBRARY_PATH:TERM"
path SANDBOX_PATH "/bin" "/usr/bin" "/usr/local/bin" "~/.local/bin" "~/go/bin"
path SANDBOX_PATH "/lib" "/lib64" "/usr/lib" "/usr/lib64"
path SANDBOX_PATH "/usr/libexec"
path SANDBOX_PATH "~/.shell_profile"

# Include Homebrew if it's installed
if [ -d "/home/linuxbrew" ]; then
    path SANDBOX_PATH "/home/linuxbrew"
fi

# Git
path SANDBOX_PATH "~/.config/git"

# Golang
path SANDBOX_PATH_RW "~/go/pkg"

# Rust
path SANDBOX_PATH "~/.rustup/toolchains" "~/.cargo/bin"
path SANDBOX_PATH_RW "~/.cargo/git" "~/.cargo/registry"

# App-specific overrides
path SANDBOX_PATH_RW_agy "~/.gemini"
path SANDBOX_PATH_RW_claude "~/.claude"
path SANDBOX_PATH_RW_codex "~/.codex"
path SANDBOX_PATH_RW_opencode "~/.config/opencode:~/.local/share/opencode:~/.local/state/opencode:~/.cache/opencode"
path SANDBOX_PATH_RW_pi "~/.pi"
