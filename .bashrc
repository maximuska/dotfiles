## .bashrc
## Author: Maxim Kalaev

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.inpurc ]; then
    export INPUTRC=~/.inputrc
fi

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

if [ -d ~/.completions ]; then
    . ~/.completions/*.bash
fi

function __stoppedjobs {
    jobs -s | wc -l | awk '$1 > 0 {print " [" $1 "]";}'
}

#PS1='[\u@\h \W$(__git_ps1 " (%s)")]$(__stoppedjobs)\$ '

export PS1='\[\e]2;\W> \H: \w\a\e[34;1m\]\h: \W$(__stoppedjobs)>\[\e[0m\] '
#export PS1="\[\e]2;\W> \H: \w\a\e[34;1m\]\h: \W\e[33;1m\]$(__git_ps1 " (%s)")\e[34;1m\]>\[\e[0m\] "

export PYTHONPATH=~/programs/lib/python2.7/site-packages:$PYTHONPATH
export PATH=~/programs/bin:~/scripts:/usr/sbin/:$PATH
export MANPATH=~/programs/man:~/programs/share/man:$MANPATH

#export LDFLAGS=-L/a/home/maximk/programs/lib
#export CPPFLAGS=-I/a/home/maximk/programs/include

export LD_LIBRARY_PATH=~/programs/lib

# Avoid having consecutive duplicate commands and other not so useful
# information appended to the history
export HISTIGNORE="&:ls:[bf]g:exit"

# - Append to history file rather than overwrite it on start
# - Allow extended glob expressions
shopt -s histappend extglob
export PROMPT_COMMAND="history -a"

# Run extra unit tests by default
export UT_ALL_TESTS=1

# Cd quickly. As a side effect of having '.', prints new directory to stdout on 'cd' to relative path
#export CDPATH=.:~:~/development

#export EDITOR=~/scripts/e

# Naming 'screen' windows by app executed / connected hosts 
screen_win_title `hostname`

# Seting dev. environment stuff
[[ -f ~/.set_target ]] && source ~/.set_target

# Hack - try preserving current working directory on SSH
if [[ -n "$LC_MY_CWD_FOR_SSH" ]]; then
    [[ -d "$LC_MY_CWD_FOR_SSH" ]] && cd $LC_MY_CWD_FOR_SSH 2>&1 > /dev/null
    export LC_MY_CWD_FOR_SSH=
fi

[[ -e /usr/bin/lesspipe ]] && export LESSOPEN=|/usr/bin/lesspipe %s
