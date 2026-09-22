#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure clean environment for test
unset SANDBOX_IMAGE SANDBOX_PATH SANDBOX_PATH_RW SANDBOX_PATH_RW_agy SANDBOX_ENV 2>/dev/null || true

# Source initialize.sh
source "${SCRIPT_DIR}/../initialize.sh"

# Assert SANDBOX_IMAGE is fedora
if [[ "${SANDBOX_IMAGE:-}" != "fedora" ]]; then
  echo "FAIL: expected SANDBOX_IMAGE to be 'fedora', got '${SANDBOX_IMAGE:-}'"
  exit 1
fi

# Assert SANDBOX_ENV contains HOME:PATH:LD_LIBRARY_PATH
if [[ "${SANDBOX_ENV:-}" != "HOME:PATH:LD_LIBRARY_PATH" ]]; then
  echo "FAIL: expected SANDBOX_ENV to be 'HOME:PATH:LD_LIBRARY_PATH', got '${SANDBOX_ENV:-}'"
  exit 1
fi

# Assert SANDBOX_PATH contains /bin, /usr, $HOME/.local/bin, and $PATH
if [[ "${SANDBOX_PATH:-}" != "/bin:/usr:${HOME}/.local/bin:${PATH}" ]]; then
  echo "FAIL: expected SANDBOX_PATH to be '/bin:/usr:${HOME}/.local/bin:${PATH}', got '${SANDBOX_PATH:-}'"
  exit 1
fi

# Assert SANDBOX_PATH_RW is empty
if [[ "${SANDBOX_PATH_RW:-}" != "" ]]; then
  echo "FAIL: expected SANDBOX_PATH_RW to be '', got '${SANDBOX_PATH_RW:-}'"
  exit 1
fi

# Assert SANDBOX_PATH_RW_agy is $HOME/.gemini
if [[ "${SANDBOX_PATH_RW_agy:-}" != "${HOME}/.gemini" ]]; then
  echo "FAIL: expected SANDBOX_PATH_RW_agy to be '${HOME}/.gemini', got '${SANDBOX_PATH_RW_agy:-}'"
  exit 1
fi

echo "PASS: Sandbox environment variables initialized correctly"
