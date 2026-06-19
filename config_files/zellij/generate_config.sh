#!/usr/bin/env bash
set -euo pipefail

cp default.kdl config.kdl
git apply patches/*
