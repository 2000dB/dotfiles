#! /bin/bash

export HISTIGNORE="&:ls:la:clear:exit:c:[*"

######## COLORS ########
export LSCOLORS="DxGxBxDxCxEgEdxbxgxcxd"
export LS_COLORS="di=1;33"
cyan='\033[0;36m\'
cyan='\033[0;36m'
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


# LINUX - should be beaglebone specific
if [[ "$OSTYPE" == "linux"* ]]; then
    export SLOTS=/sys/devices/bone_capemgr.9/slots 
    export PINS=/sys/kernel/debug/pinctrl/44e10800.pinmux/pins
    export DEBUG_PINS=/sys/kernel/debug/gpio
    export LD_LIBRARY_PATH=/usr/local/lib:/usr/xenomai/lib

    export EDITOR=nano

    export PS1="$cyan[$WHITE\H@$cyan\W]$WHITE\$(parse_git_branch)$WHITE> $NC"

    alias ls="ls -hl --color"
    alias la="ls -ahl --color"

    

# OSX
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/lib/python2.7/site-packages:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
    
    # CrossPack
    if [ -d /usr/local/CrossPack-AVR ]; then
	export PATH=/usr/local/CrossPack-AVR/bin:$PATH
	export MANPATH=/usr/local/CrossPack-AVR/man:$MANPATH
    fi

    # ARM
    if [ -d /usr/local/arm/gcc-arm-none-eabi ]; then
        export PATH=/usr/local/arm/gcc-arm-none-eabi/bin:$PATH
    fi

    # Brew
    export PATH=/usr/local/bin:$PATH
    if [ 'command -v brew' ]; then
	export PATH=/usr/local/share/python:/usr/local/sbin:$PATH
	
	if [ -f `brew --prefix`/etc/bash_completion ]; then
	    . `brew --prefix`/etc/bash_completion
	fi
    fi    




    # go
    export GOPATH=$HOME/go
    export GOROOT="/usr/local/opt/go/libexec"
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin

    # Python
    export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

    export WORKON_HOME="~/.virtualenvs"
    source /usr/local/bin/virtualenvwrapper.sh

    export EDITOR="emacsclient -na vi" # Use emacsclient, fallback on vi if not available

    PS1="$cyan[\W]$WHITE\$(parse_git_branch)$WHITE> $NC"

    alias ls="ls -hlG"
    alias la="ls -ahlG"


fi

######## PROMPT ########
# case "$TERM" in
#     "dumb")
# 	PS1="> "
# 	;;
#     xterm*|rxvt*|eterm*|screen*)
# 	;;
#     linux*)

# 	;;
#     *)
# 	PS1="> "
# 	;;
#     esac


######## ALIASES ########

# Default editor - emacsclient, fallback on vi if not available.  XXX: fix this, doesn't work as git editor.

alias ..="cd .."
alias ~="cd ~"

alias grep="grep --color"
alias c="clear"
alias ip="curl http://ip.appspot.com"

alias e="emacs -nw"
alias emacs="emacs -nw"
alias ec="emacsclient -n"
alias sch="gschem"

alias uva="cd ~/UVA/"

alias 201="ssh root@20.0.0.201"
alias 202="ssh root@20.0.0.202"
alias 203="ssh root@20.0.0.203"

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


create_repo()
{
    service=$1
    repo_name=$2
    is_private=$3

    username=""
    pass=""

    
    if [ "$service" == "--help" ]; then
        echo "create_repo service repo_name private[true/false]"
        exit 1
    fi
    
    # deal with password
    if [  "$service" == "github" ]; then
        curl -s -u "2000db" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'
    elif [ "$service" == "bitbucket" ]; then
        curl -s -u "vincent-uva" https://api.bitbucket.org/1.0/repositories/ --data name="$repo_name" --data is_private="$is_private"
    fi

}
