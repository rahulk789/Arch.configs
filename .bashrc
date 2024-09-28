#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#android studio 
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
#close
export EDITOR='vim'
export VISUAL='vim'
export PATH=$PATH:~/.config/rofi/applets/applets
export PATH=$PATH:~/.config/rofi/bin
export PATH=$PATH:~/.cargo/bin
export HISTCONTROL=ignoreboth
#export TERM=xterm-256color
shopt -s autocd
shopt -s cdspell
alias ls='ls -la --color=auto'
alias grep='grep --color=auto'
PS1='\033[1;31m\]\u@\033[1;36m\]\h \033[1;31m\]\W\033[0m\] \$ '
#export PATH=$PATH:/home/xenon/projects/pswdman/pswdman
#PS1="\n \[\033[0;34m\]┌─────(\[\033[1;35m\]\u\[\033[0;34m\])─────(\[\033[1;32m\]\w\[\033[0;34m\]) \n └> \[\033[1;36m\]\$ \[\033[0m\]"
#PS1="$PS1"'\[\e[0m\]' # reset all
#PS1='[\[\033[1;31m\]\u@\[\033[1;36m\]\h \[\033[1;31m\]\W\[\033[0m\]]\$ '
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
