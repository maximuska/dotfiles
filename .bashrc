# .bashrc

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

PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

export PS1="\[\e]2;\W> \H: \w\a\e[34;1m\]\h: \W>\[\e[0m\] "
#export PS1="\[\e]2;\W> \H: \w\a\e[34;1m\]\h: \W\e[33;1m\]$(__git_ps1 " (%s)")\e[34;1m\]>\[\e[0m\] "

export PYTHONPATH=~/lib:$PYTHONPATH
export PATH=~/programs/bin:~/scripts:$PATH
export MANPATH=~/programs/man:~/programs/share/man:$MANPATH

export LDFLAGS=-L/a/home/maximk/programs/lib
export CPPFLAGS=-I/a/home/maximk/programs/include

# Avoid having consecutive duplicate commands and other not so useful
# information appended to the history
export HISTIGNORE="&:ls:[bf]g:exit"

# Append to history file rather than overwrite it on start
shopt -s histappend
export PROMPT_COMMAND="history -a"

# Cd quickly
export CDPATH=.:~:~/development

export EDITOR=~/scripts/e.sh

# Naming 'screen' windows by app executed / connected hosts 
screen_win_title "bash"
