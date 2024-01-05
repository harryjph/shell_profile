function sshagent() {
    eval $(ssh-agent)
    ssh-add ~/.ssh/id_ed25519
}

function sshagentk() {
    kill $(pidof ssh-agent)
}
