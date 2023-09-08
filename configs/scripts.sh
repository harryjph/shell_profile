export PATH="$HOME/.shell_profile/scripts:$PATH"
export PATH="$HOME/.shell_profile/test_scripts:$PATH"

# Shorthand for scripts
alias myd="mysqld"
alias chd="clickhoused"

# clusterup magic
alias clusterup="clusterup && export KUBECONFIG=~/.shell_profile/scripts/k3s/kubeconfig.yaml"
