#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../initialize.sh"
SANDBOX="${SCRIPT_DIR}/../scripts/sandbox"

test_file="./.sandbox_test_rw_probe"
app_probe_dir=""

cleanup() {
  rm -f "$test_file"
  if [[ -n "$app_probe_dir" && -d "$app_probe_dir" ]]; then
    rm -rf "$app_probe_dir"
  fi
  rm -rf /tmp/sandbox_probe_* 2>/dev/null || true
}
trap cleanup EXIT INT TERM

echo "=== Test 1: Basic execution and stdout ==="
out=$("$SANDBOX" echo "sandbox is live")
if [[ "$out" != *"sandbox is live"* ]]; then
  echo "FAIL: Expected 'sandbox is live', got '$out'"
  exit 1
fi

echo "=== Test 2: Current working directory passthrough ==="
container_pwd=$("$SANDBOX" pwd)
host_pwd="$(pwd)"
if [[ "$container_pwd" != "$host_pwd" ]]; then
  echo "FAIL: container pwd '$container_pwd' != host pwd '$host_pwd'"
  exit 1
fi

echo "=== Test 3: Read-only enforcement on host mounts ==="
if "$SANDBOX" touch /usr/sandbox_ro_test_probe &>/dev/null; then
  echo "FAIL: /usr was writable inside sandbox!"
  exit 1
else
  echo "PASS: /usr is read-only"
fi

echo "=== Test 4: Read-write enforcement in current working directory ==="
rm -f "$test_file"
"$SANDBOX" touch "$test_file"
if [[ ! -f "$test_file" ]]; then
  echo "FAIL: file was not created in cwd"
  exit 1
fi
rm -f "$test_file"
echo "PASS: CWD is read-write"

echo "=== Test 5: Pipe / non-interactive stdin support ==="
piped_res=$(echo "streamed text" | "$SANDBOX" cat)
if [[ "$piped_res" != "streamed text" ]]; then
  echo "FAIL: piped stdin test failed, got '$piped_res'"
  exit 1
fi

echo "=== Test 6: App-specific override ==="
app_probe_dir=$(mktemp -d /tmp/sandbox_probe_XXXXXX)
SANDBOX_PATH_RW_touch="$app_probe_dir" "$SANDBOX" touch "${app_probe_dir}/created_by_app"
if [[ ! -f "${app_probe_dir}/created_by_app" ]]; then
  echo "FAIL: app-specific RW mount not applied"
  exit 1
fi
rm -rf "$app_probe_dir"
app_probe_dir=""
echo "PASS: app-specific mount verified"

echo "=== Test 7: Security hardening verification ==="
container_uid=$("$SANDBOX" id -u)
host_uid="$(id -u)"
if [[ "$container_uid" != "$host_uid" ]]; then
  echo "FAIL: container uid '$container_uid' != host uid '$host_uid'"
  exit 1
fi

cap_eff=$("$SANDBOX" sh -c "grep CapEff /proc/self/status")
if [[ "$cap_eff" != *"0000000000000000"* ]]; then
  echo "FAIL: CapEff is not 0000000000000000: '$cap_eff'"
  exit 1
fi

no_new_privs=$("$SANDBOX" sh -c "grep NoNewPrivs /proc/self/status")
if [[ "$no_new_privs" != *"1"* ]]; then
  echo "FAIL: NoNewPrivs is not 1: '$no_new_privs'"
  exit 1
fi
echo "PASS: Security hardening verified"
 
echo "=== Test 8: Environment passthrough (HOME, PATH, custom SANDBOX_ENV) ==="
container_home=$("$SANDBOX" sh -c 'echo "$HOME"')
if [[ "$container_home" != "$HOME" ]]; then
  echo "FAIL: container HOME '$container_home' != host HOME '$HOME'"
  exit 1
fi

container_path=$("$SANDBOX" sh -c 'echo "$PATH"')
if [[ "$container_path" != "$PATH" ]]; then
  echo "FAIL: container PATH '$container_path' != host PATH '$PATH'"
  exit 1
fi

custom_env_res=$(SANDBOX_ENV_printenv="CUSTOM_SANDBOX_VAR" CUSTOM_SANDBOX_VAR="hello_from_host" "$SANDBOX" printenv CUSTOM_SANDBOX_VAR)
if [[ "$custom_env_res" != "hello_from_host" ]]; then
  echo "FAIL: custom SANDBOX_ENV not passed through: '$custom_env_res'"
  exit 1
fi

ld_res=$(LD_LIBRARY_PATH="/usr/lib64" "$SANDBOX" printenv LD_LIBRARY_PATH)
if [[ "$ld_res" != "/usr/lib64" ]]; then
  echo "FAIL: LD_LIBRARY_PATH not passed through: '$ld_res'"
  exit 1
fi
echo "PASS: Environment passthrough verified"

echo "ALL SANDBOX INTEGRATION TESTS PASSED!"
