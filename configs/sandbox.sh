#!/usr/bin/env bash

# Basic sandbox config
export SANDBOX_IMAGE="fedora"
export SANDBOX_ENV="HOME:PATH:LD_LIBRARY_PATH:TERM"
export SANDBOX_PATH="$PATH:$LD_LIBRARY_PATH"

# Include Homebrew if it's installed
if [ -d "/home/linuxbrew" ]; then
    SANDBOX_PATH="$SANDBOX_PATH:/home/linuxbrew"
fi

# App-specific overrides
export SANDBOX_PATH_RW_agy="~/.gemini"
export SANDBOX_PATH_RW_claude="~/.claude"
export SANDBOX_PATH_RW_codex="~/.codex"
export SANDBOX_PATH_RW_opencode="~/.config/opencode:~/.local/share/opencode:~/.local/state/opencode:~/.cache/opencode"
export SANDBOX_PATH_RW_pi="~/.pi"
