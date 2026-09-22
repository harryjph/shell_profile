#!/usr/bin/env bash

export SANDBOX_IMAGE="${SANDBOX_IMAGE:-fedora}"

# Environment variables to pass into the sandbox
sandbox_env_vars=(
  HOME
  PATH
  LD_LIBRARY_PATH
)
_default_sandbox_env=$(IFS=:; echo "${sandbox_env_vars[*]}")
export SANDBOX_ENV="${SANDBOX_ENV:-$_default_sandbox_env}"

# Read-only paths to mount into the sandbox
sandbox_ro_paths=(
  /bin
  /usr
  "${HOME}/.local/bin"
  "${PATH}"
)
if [[ -n "${LD_LIBRARY_PATH:-}" ]]; then
  sandbox_ro_paths+=("${LD_LIBRARY_PATH}")
fi
_default_sandbox_path=$(IFS=:; echo "${sandbox_ro_paths[*]}")
export SANDBOX_PATH="${SANDBOX_PATH:-$_default_sandbox_path}"

# Read-write paths to mount into the sandbox
sandbox_rw_paths=()
_default_sandbox_path_rw=$(IFS=:; echo "${sandbox_rw_paths[*]}")
export SANDBOX_PATH_RW="${SANDBOX_PATH_RW:-$_default_sandbox_path_rw}"

# App-specific overrides
export SANDBOX_PATH_RW_agy="${SANDBOX_PATH_RW_agy:-${HOME}/.gemini}"
