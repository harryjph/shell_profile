#!/usr/bin/env bash

declare -a apps=(

# Basic utilities
bat
file
less
nano
htop
neofetch
ssh
mosh
ncdu
grep
sed

# Shells / Scripting utilities
zsh
pv
jq
rlwrap

# Compilers / Build Tools
gcc
make
go
cargo

# Interpreters / REPLs
yaegi

# Networking utilities
curl
wget
bmon
arp-scan

# Compression utilities
gzip
gunzip
zip
unzip
bzip2
bunzip2
lz4
xz
zstd

# Crypto utilities
sha256sum
sha3sum

# Kubernetes
#kubectl
#k9s
#helm

# Kafka
#kcl

)

function check_app() {
  appName=$1
  if ! which $appName > /dev/null 2>&1; then
    echo "warning: $appName is not installed"
  fi
}

for i in "${apps[@]}"; do
  check_app $i
done
