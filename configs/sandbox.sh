#!/usr/bin/env bash

export SANDBOX_IMAGE="fedora"
export SANDBOX_ENV="HOME:PATH:LD_LIBRARY_PATH:TERM"
export SANDBOX_PATH="$PATH:$LD_LIBRARY_PATH:/home/linuxbrew"

# App-specific overrides
export SANDBOX_PATH_RW_agy="~/.gemini"
export SANDBOX_PATH_RW_opencode="~/.config/opencode:~/.local/share/opencode:~/.local/state/opencode:~/.cache/opencode"
