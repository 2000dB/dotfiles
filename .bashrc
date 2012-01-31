#! /bin/bash

export LC_CTYPE=en_US.UTF-8


export HISTIGNORE="&:ls:clear:exit:c"

export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/lib/python2.7/site-packages:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

#AVR CROSSPACK
export PATH=$PATH:/usr/local/CrossPack-AVR/bin

# LIBMAPLE STUFF
export LIB_MAPLE_HOME=/usr/local/libmaple
export PATH=$PATH:$LIB_MAPLE_HOME/arm/bin

# Android SDK
export PATH=$PATH:/Developer/android-sdk-mac_x86/tools:/Developer/android-sdk-mac_x86/platform-tools

# Python
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:/usr/local/Cellar/scons/2.1.0/lib/scons

alias ..="cd .."
alias ~="cd ~"
alias ls="ls -laG"
alias grep="grep --color"
alias c="clear"
alias l="ls -laG"
alias emacs="emacs -nw"

alias e="cd ~/Documents/eski/"

# Define colors
cyan='\[\033[0;36m\]'
WHITE='\[\033[1;37m\]'
NC='\[\033[0m\]'

# Prompt
PS1="$cyan[\W] $WHITE> $NC"
