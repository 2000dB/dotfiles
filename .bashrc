#! /bin/bash

export LC_CTYPE=en_US.UTF-8

export HISTIGNORE="&:ls:la:clear:exit:c:[*"


# LINUX
if [[ "$OSTYPE" == "linux"* ]]; then

    export LD_LIBRARY_PATH=/usr/local/lib:/usr/xenomai/lib

# OSX
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # CrossPack
    if [ -d /usr/local/CrossPack-AVR ]; then
	export PATH=/usr/local/CrossPack-AVR/bin:$PATH
	export MANPATH=/usr/local/CrossPack-AVR/man:$MANPATH
    fi

    # Brew
    export PATH=/usr/local/bin:$PATH
    if [ 'command -v brew' ]; then
	export PATH=/usr/local/share/python:/usr/local/sbin:$PATH
	
	if [ -f `brew --prefix`/etc/bash_completion ]; then
	    . `brew --prefix`/etc/bash_completion
	fi
    fi    

# Python
    export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

    export WORKON_HOME="~/.virtualenvs"
    source /usr/local/share/python/virtualenvwrapper.sh
fi




######## ALIASES ########

# Default editor - emacsclient, fallback on vi if not available.  XXX: fix this, doesn't work as git editor.
export EDITOR="emacsclient -na vi"

alias ..="cd .."
alias ~="cd ~"
alias grep="grep --color"
alias c="clear"
alias ip="curl http://ip.appspot.com"

alias ls="ls -hlG"
alias la="ls -ahlG"

alias e="emacs -nw"
alias emacs="emacs -nw"
alias ec="emacsclient -n"

alias p="cd ~/Projects/"
alias uva="cd ~/Projects/UVA/"

######## COLORS ########
cyan='\033[0;36m\'
purp='\033[0;35m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
NC='\033[0m'

######## PROMPT ########
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

# ssh wrapper that rename current tmux window to the hostname of the
# remote host.
settitle() {

    printf "\033k$1\033\\"
}

ssh() {
    name=$(echo $* | cut -d'@' -f2 | cut -d'.' -f1)
    settitle $name
    command ssh "$@"
    settitle "bash"
}

PS1="$cyan[[\W]$WHITE\$(parse_git_branch)$WHITE> $NC"
#PS1="$cyan[[\W]$WHITE\$WHITE> $
