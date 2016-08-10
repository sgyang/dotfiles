[ -z "$PS1" ] && return
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTFILESIZE=20000
shopt -s histappend
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ls='ls --color --group-directories-first'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -l'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# tmux
alias ta='tmux a -t'
alias tn='tmux new -s'
alias tls='tmux ls'

# Common environment variables
export PATH=$HOME/bin:$PATH
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="FRSX"
export EDITOR="emacs"

# Common aliases
alias ls='ls --color --group-directories-first'

# Go
export GOPATH=$HOME/go
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

# Java
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Docker
alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias docker-rm="docker rm -v \$(docker ps -a -q --filter status=exited)"
alias docker-rmi="docker rmi \$(docker images -q --filter dangling=true)"

# Completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Local settings
if [ -f ~/.bashrc_private ]; then
    . ~/.bashrc_private
fi
