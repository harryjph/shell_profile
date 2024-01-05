function sshagent() {
    eval $(ssh-agent)
    ssh-add ~/.ssh/id_ed25519
}

function sshagentk() {
    pids=$(pidof ssh-agent)
    if [[ "$pids" != "" ]]; then; kill $pids; fi
}
