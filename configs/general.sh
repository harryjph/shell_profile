# Setup editor
export EDITOR=nano
export PAGER=bat

alias cp="cp -i" # Confirm before overwriting something

# Setup colours in ls
export LS_OPTIONS='--color=auto'
if which dircolors > /dev/null 2>/dev/null; then eval "$(dircolors -b)"; fi
alias ls='ls $LS_OPTIONS'
alias lsl="ls -alh"

# Setup colours in man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Fix bat under Debian
if which batcat > /dev/null 2>&1; then alias bat=batcat; fi

# Paged diff
function dif() {
	diff $1 $2 | bat -l=diff
}
