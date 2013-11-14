#! /bin/bash

#export LC_CTYPE=en_US.UTF-8

#export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/lib/python2.7/site-packages:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

#if [ -f `brew --prefix`/etc/bash_completion ]; then
#    . `brew --prefix`/etc/bash_completion
#fi

#AVR Crosspack
#export PATH=$PATH:/usr/local/CrossPack-AVR/bin

# Python
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:/usr/local/Cellar/scons/2.1.0/lib/scons

#export EDITOR="emacsclient -na vi" # Use emacsclient, fallback on vi if not available

export HISTIGNORE="&:ls:la:clear:exit:c"

alias ..="cd .."
alias ~="cd ~"
alias p="cd ~/Documents/Projects/"
alias ls="ls -hlG"
alias la="ls -ahlG"
alias grep="grep --color"
alias c="clear"
alias e="emacs -nw"
alias emacs="emacs -nw"
alias ec="emacsclient -n"

# COLORS
cyan='\033[0;36m'
purp='\033[0;35m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
NC='\033[0m'

function parse_git_dirty() {
    if [ -d .git ]; then
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
    fi
    }

function parse_git_branch() {
    if [ -d .git ]; then
	echo -e $purp"["$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")$YELLOW$(parse_git_dirty)$purp"]"
    else
	echo ""
    fi
    }


# PROMPT
export PS1="$cyan[$WHITE\H@$cyan\W]$WHITE\$(parse_git_branch)$WHITE> $NC"
