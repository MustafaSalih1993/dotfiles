# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

source "$HOME/.config/git-prompt.sh"
source "$HOME/.cargo/env"


alias la="lsd -A --color=auto"
alias ls="lsd  --color=auto"
alias ..="cd .."
alias e="emacs -nw"


export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="\n\[$(tput setaf 13)\]┏━━━┃\[$(tput setaf 15)\]\u\[$(tput setaf 60)\]@\[$(tput setaf 15)\]\h\[$(tput setaf 13)\]┃\[$(tput setaf 2)\]\$(__git_ps1)\[$(tput setaf 13)\]┃\[$(tput setaf 1)\]\w\[$(tput setaf 13)\]┃\n┃\n\n\[$(tput sgr0)\]$ "

# export PS1="\n\$(__git_ps1)\n\[$(tput setaf 13)\][\[$(tput setaf 15)\]\u\[$(tput setaf 60)\]@\[$(tput setaf 15)\]\h\[$(tput setaf 15)\] \W\[$(tput setaf 13)\]]  \[$(tput sgr0)\]"
