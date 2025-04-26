alias gc="git commit"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcl="git clone --recursive"
alias gpl="git pull"
alias gp="git push"
alias gf="git fetch"
alias ga="git add"
alias gad="git add ."
alias gs="git status"
alias glo="git log --oneline"
alias gsw="git switch"
alias grh="git reset --hard"
alias gitclean="git clean -xdf"

function gacp() {
  git add . && git commit -m "$1" && git push
}

# Git Delete All Branches
alias git-dab="git for-each-ref --format '%(refname:lstrip=2)' refs/heads | grep -v \"master\|main\" | xargs git branch -D"
