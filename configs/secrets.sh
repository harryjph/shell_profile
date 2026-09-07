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
