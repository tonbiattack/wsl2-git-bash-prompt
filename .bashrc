source /usr/lib/git-core/git-sh-prompt 2>/dev/null || source /etc/bash_completion.d/git-prompt 2>/dev/null

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

export PS1='\[\e[32m\]\u@\h\[\e[0m\] \[\e[33m\]\w\[\e[0m\]$(__git_ps1 " \[\e[34m\](%s)\[\e[0m\]")\n\$ '