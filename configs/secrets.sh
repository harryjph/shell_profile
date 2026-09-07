load_secret() {
  local var_name="$1"
  if [[ -z "$var_name" ]]; then
    echo "Error: No variable name provided." >&2
    return 1
  fi

  local state_dir="${XDG_STATE_HOME:-$HOME/.local/state/.secrets}"
  local secret_file="$state_dir/${var_name}"

  if [[ ! -s "$secret_file" ]]; then
    mkdir -p "$state_dir"

    # Force the prompt and input to use the active terminal device (/dev/tty)
    printf "Enter value for %s: " "$var_name" > /dev/tty
    local user_input
    read -r -s user_input < /dev/tty
    echo > /dev/tty

    (umask 077 && printf '%s=%q\n' "$var_name" "$user_input" > "$secret_file")
  fi

  source "$secret_file"
  export "$var_name"
}

bw_login() {
  local state_dir="${XDG_STATE_HOME:-$HOME/.local/state/.secrets}"

  # Load BW_SESSION from disk if not already set in the current shell
  if [[ -z "$BW_SESSION" && -s "$state_dir/BW_SESSION" ]]; then
    source "$state_dir/BW_SESSION"
    export BW_SESSION
  fi

  # Exit early if already logged in and the session key is valid
  if bw login --check >/dev/null 2>&1 && bw unlock --check --session "$BW_SESSION" >/dev/null 2>&1; then
    echo "Already logged in"
    return 0
  fi

  # Otherwise, perform fresh login and unlock
  bw logout 2>/dev/null || true
  
  load_secret BW_SERVER
  load_secret BW_CLIENTID
  load_secret BW_CLIENTSECRET

  bw config server "$BW_SERVER"
  bw login --apikey --raw
  export BW_SESSION="$(bw unlock --raw)"

  # Save BW_SESSION to the secrets directory with restricted permissions
  mkdir -p "$state_dir"
  (umask 077 && printf 'BW_SESSION=%q\n' "$BW_SESSION" > "$state_dir/BW_SESSION")

  unset BW_SERVER
  unset BW_CLIENTID
  unset BW_CLIENTSECRET

  bw unlock --check
}
