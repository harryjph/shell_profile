function start() {
  if ! docker container ls | grep \\s$CONTAINER_NAME$ > /dev/null; then
    if ! docker container ls -a | grep \\s$CONTAINER_NAME$ > /dev/null; then
      create
      echo "Created."
    else
      docker start $CONTAINER_NAME > /dev/null || exit $?
      echo "Started."
    fi
  else
    echo "Already running."
  fi
}

function status() {
  if ! docker container ls | grep \\s$CONTAINER_NAME$ > /dev/null; then
    if ! docker container ls -a | grep \\s$CONTAINER_NAME$ > /dev/null; then
      echo "Status: Not initialized"
    else
      echo "Status: Stopped"
    fi
  else
    echo "Status: Running"
  fi
}

function logs() {
  docker logs $CONTAINER_NAME
}

function stop() {
  docker stop $CONTAINER_NAME > /dev/null || exit $?
  echo "Stopped."
}

function remove() {
  stop
  docker rm $CONTAINER_NAME > /dev/null || exit $?
  echo "Removed."
}

function shell() {
  docker exec -it $CONTAINER_NAME sh
}

case "$1" in
  start) start;;
  status) status;;
  logs) logs;;
  stop) stop;;
  rm) remove;;
  restart) stop; start;;
  reset) remove; start;;
  shell) shell;;
  sh) shell;;
  *) echo "usage: $CONTAINER_NAME start|stop|status|logs|rm|restart|reset|shell|sh" >&2
     exit 1;;
esac
