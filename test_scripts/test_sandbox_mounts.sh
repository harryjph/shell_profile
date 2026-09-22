#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SANDBOX="${SCRIPT_DIR}/../scripts/sandbox"

# Test harness using SANDBOX_DRY_RUN=1 to inspect generated podman args
export SANDBOX_DRY_RUN=1
export SANDBOX_IMAGE="fedora"
export SANDBOX_PATH="/usr:/bin:${HOME}/.local/bin"
export SANDBOX_PATH_RW="/tmp"
export SANDBOX_PATH_RW_testtool="/var/tmp"
export SANDBOX_ENV="HOME:PATH:LD_LIBRARY_PATH"
export SANDBOX_ENV_testtool="CUSTOM_TOOL_VAR"

# Create dummy test directories if needed
mkdir -p "${HOME}/.local/bin"
dummy_lib="${HOME}/.test_dummy_lib_$$"
mkdir -p "$dummy_lib"
export LD_LIBRARY_PATH="$dummy_lib"

output=$("$SANDBOX" testtool --version)
rm -rf "$dummy_lib"

# Assertions
echo "$output" | grep -q -- "-v /usr:/usr:ro" || { echo "FAIL: missing /usr ro mount"; exit 1; }
echo "$output" | grep -q -- "-v /bin:/bin:ro" || { echo "FAIL: missing /bin ro mount"; exit 1; }
echo "$output" | grep -q -- "-v ${HOME}/.local/bin:${HOME}/.local/bin:ro" || { echo "FAIL: missing ~/.local/bin ro mount"; exit 1; }
echo "$output" | grep -q -- "-v /tmp:/tmp:rw" || { echo "FAIL: missing /tmp rw mount"; exit 1; }
echo "$output" | grep -q -- "-v /var/tmp:/var/tmp:rw" || { echo "FAIL: missing testtool rw mount"; exit 1; }
echo "$output" | grep -q -- "-v $(pwd):$(pwd):rw" || { echo "FAIL: missing cwd rw mount"; exit 1; }
echo "$output" | grep -q -- "-v ${dummy_lib}:${dummy_lib}:ro" || { echo "FAIL: missing LD_LIBRARY_PATH ro mount"; exit 1; }
echo "$output" | grep -q -- "--workdir $(pwd)" || { echo "FAIL: missing workdir"; exit 1; }
echo "$output" | grep -q -- "-e HOME" || { echo "FAIL: missing -e HOME in podman args"; exit 1; }
echo "$output" | grep -q -- "-e PATH" || { echo "FAIL: missing -e PATH in podman args"; exit 1; }
echo "$output" | grep -q -- "-e LD_LIBRARY_PATH" || { echo "FAIL: missing -e LD_LIBRARY_PATH in podman args"; exit 1; }
echo "$output" | grep -q -- "-e CUSTOM_TOOL_VAR" || { echo "FAIL: missing app-specific -e CUSTOM_TOOL_VAR"; exit 1; }
echo "$output" | grep -q -- "fedora testtool --version" || { echo "FAIL: missing target execution command"; exit 1; }

echo "PASS: Mount resolution and dry-run output verified"
