alias dcup="docker compose up -d"
alias dcd="docker compose down"
alias dcls="docker container ls -a --format \"table {{.Names}}\t{{.Image}}\t{{.Status}}\""

function dcrm() {
  docker container stop "$1" > /dev/null || exit
  docker container rm "$1" > /dev/null || exit
  echo "Removed."
}

alias list_container_names="docker container ls -a --format \"table {{.Names}}\" | grep -v ^NAMES$"
alias dcstop="list_container_names | xargs docker stop"
alias dcpurge="list_container_names | xargs -I % sh -c 'docker stop % && docker rm %'"
