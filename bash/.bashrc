if [[ $- != *i* ]] ; then
    return
fi

# Test for an interactive shell
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Showing dirty status in git directories
export GIT_PS1_SHOWDIRTYSTATE=1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.
shopt -s checkwinsize
# Disable completion when the input buffer is empty.
shopt -s no_empty_cmd_completion
# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend
# Change the window title of X terminals 
case ${TERM} in
    [aEkx]term*|rxvt*|gnome*|konsole*|interix|tmux*)
	PS1='\[\033]0;\u@\h:\w\007\]'
	;;
    screen*)
	PS1='\[\033k\u@\h:\w\033\\\]'
	;;
    *)
	unset PS1
	;;
esac

use_color=false
if type -P dircolors >/dev/null ; then
    # Enable colors
    LS_COLORS=
    if [[ -f ~/.dir_colors ]] ; then
	eval "$(dircolors -b ~/.dir_colors)"
    elif [[ -f /etc/DIR_COLORS ]] ; then
	eval "$(dircolors -b /etc/DIR_COLORS)"
    else
	eval "$(dircolors -b)"
    fi

    if [[ -n ${LS_COLORS:+set} ]] ; then
	use_color=true
    else
	# Delete it if it's empty as it's useless in that case.
	unset LS_COLORS
    fi
else
    case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|screen|tmux|cons25|*color) use_color=true;;
    esac
fi

if ${use_color} ; then
    NORMAL="\[\e[0m\]"
    RED="\[\e[38;2;247;118;142m\]"
    GREEN="\[\e[38;2;158;206;106m\]"
    BLUE="\[\e[38;2;122;162;247m\]"
    CYAN="\[\e[38;2;68;157;171m\]"
    if [[ ${EUID} == 0 ]] ; then
	PS1+='\[\033[01;31m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '

    else
	PS1+="\n$RED┃$NORMAL\u@\h$GREEN┃\$(__git_ps1)$GREEN┃$NORMAL\w$BLUE┃\n\n$RED❯$GREEN❯$BLUE❯$NORMAL "
	#PS1+='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
    fi
else
    # show root@ when we don't have colors
    PS1+='\u@\h \w \$ '
fi

source "$HOME/.config/git-prompt.sh"
source "$HOME/.cargo/env"
for sh in /etc/bash/bashrc.d/* ; do
    [[ -r ${sh} ]] && source "${sh}"
done
# Try to keep environment pollution down, EPA loves us.
unset use_color sh
# ls command aliases
alias la="lsd -A --color=auto"
alias ls="lsd  --color=auto"
alias ll="lsd -l  --color=auto"
alias grep='rg --colour=auto'
# alias up directory
alias ..="cd .."
# starts emacs without GUI
alias e="emacs -nw"
# update Gentoo mirrors by selecting the fastest 3 mirrors
alias mkmirror="doas mirrorselect -s3 -b10 -D"
# update Gentoo repository and update the system
alias up="doas emerge -uND --with-bdeps=y @world"
