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
NORMAL="\e[0m"
RED="\e[0;31m"
GREEN="\e[0;32m"
BLUE="\e[0;34m"
#YELLOW='\e[0;33m'
#PURPLE='\e[0;35m'
CYAN="\e[0;36m"

source "$HOME/.config/git-prompt.sh"
source "$HOME/.cargo/env"

# ls command aliases
alias la="lsd -A --color=auto"
alias ls="lsd  --color=auto"
alias ll="lsd -l  --color=auto"
# alias up directory
alias ..="cd .."
# starts emacs without GUI
alias e="emacs -nw"
# update Gentoo mirrors by selecting the fastest 3 mirrors
alias mkmirror="doas mirrorselect -s3 -b10 -D"
# update Gentoo repository and update the system and clean after
alias up="doas emerge -uND --with-bdeps=y @world &&\
 doas emerge --depclean &&\
 doas eclean-dist --deep"
# Showing dirty status in git directories
export GIT_PS1_SHOWDIRTYSTATE=1
# PS1/prompt
# PS1="\n$RED┃$NORMAL\u@\h$GREEN┃\$(__git_ps1)$GREEN┃$NORMAL\w"
# PS1="${PS1}$BLUE┃\n\n$RED❯$GREEN❯$BLUE❯$NORMAL"
PS1="\n┃\u@\h┃\$(__git_ps1)┃\w"
PS1="${PS1}┃\n\n❯❯❯"
export PS1="${PS1} "
