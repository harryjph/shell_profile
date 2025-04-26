## Setup editor
export EDITOR=micro
export PAGER="bat --wrap never"

# Aliases to view/edit a file
alias e="$EDITOR"
function v() {
	target="$1"
	if [ -d "$target" ] ; then
	    ls "$target"
	else
	    eval "$PAGER" "$target"
	fi
}
# VJ = View Json
function vj() {
	jq . $1 | eval "$PAGER" -l json
}

# Fast Watch
alias watch="watch -n 0.1"

alias cp="cp -i" # Confirm before overwriting something

# ls/eza setup
function ls() {
	if which eza > /dev/null 2>&1; then
	  eza --icons=auto --group --smart-group --header --links --mounts --git "$@"
	else
	  ls --color=auto "$@"
	fi
}
function tree() {
	if which eza > /dev/null 2>&1; then
	  ls --tree "$@"
	else
	  tree "$@"
	fi
}
if which dircolors > /dev/null 2>/dev/null; then eval "$(dircolors -b)"; fi
alias ll="ls -alh"

# Setup colours in man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Fix bat under Debian
if which batcat > /dev/null 2>&1; then alias bat=batcat; fi

# Paged diff
function dif() {
	diff $1 $2 | bat -l=diff
}
