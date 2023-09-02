alias cp="cp -i" # Confirm before overwriting something

# Setup colours in ls
export LS_OPTIONS='--color=auto'
if which dircolors > /dev/null 2>/dev/null; then eval "$(dircolors -b)"; fi
alias ls='ls $LS_OPTIONS'