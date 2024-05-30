C=$HOME/.shell_profile/configs

if [ -n "$ZSH_VERSION" ]; then
  source $C/zsh.sh
fi

source $C/general.sh
source $C/scripts.sh
source $C/go.sh
source $C/git_aliases.sh
source $C/docker_aliases.sh
source $C/kube_aliases.sh
source $C/python.sh
source $C/lolz.sh
source $C/fs.sh
source $C/ssh.sh
source $C/tools.sh
