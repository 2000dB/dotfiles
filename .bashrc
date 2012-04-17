#! /bin/bash

export LC_CTYPE=en_US.UTF-8

export HISTIGNORE="&:ls:clear:exit:c"

export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/lib/python2.7/site-packages:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

#AVR CROSSPACK
export PATH=$PATH:/usr/local/CrossPack-AVR/bin

# Python
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:/usr/local/Cellar/scons/2.1.0/lib/scons

export EDITOR="emacsclient -na vi" # Use emacsclient, fallback on vi if not available

alias ..="cd .."
alias ~="cd ~"
alias ls="ls -laG"
alias grep="grep --color"
alias c="clear"
alias l="ls -laG"
alias e="emacs -nw"
alias emacs="emacs -nw"
alias ec="emacsclient -n"

# Define colors
cyan='\[\033[0;36m\]'
WHITE='\[\033[1;37m\]'
NC='\[\033[0m\]'

# Prompt
PS1="$cyan[\W] $WHITE> $NC"

