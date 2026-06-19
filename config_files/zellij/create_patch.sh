#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]
  then
    echo "Specify a patch name as first argument"
    exit 1
fi

# Undo other patches to get just this patch's diff from default
git apply -R patches/*

# Create the patch. `diff` exits nonzero when there's a diff
(diff -u default.kdl config.kdl || true) > "patches/$1.patch"

# Re-generate the config
./generate_config.sh
