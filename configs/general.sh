# Setup editor
export EDITOR=nano

alias cp="cp -i" # Confirm before overwriting something

# Setup colours in ls
export LS_OPTIONS='--color=auto'
if which dircolors > /dev/null 2>/dev/null; then eval "$(dircolors -b)"; fi
alias ls='ls $LS_OPTIONS'

# Setup colours in man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Fix bat under Debian
if which batcat > /dev/null 2>&1; then alias bat=batcat; fi
