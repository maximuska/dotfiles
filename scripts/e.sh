#!/bin/bash 

if ! emacsclient -e t >/dev/null 2>&1  
then
    exec emacs "$@" &
else
for f in "$@"; do
    if [[ $f =~ "(.*):([0-9]+):?" ]]
    then
        emacsclient -n +${BASH_REMATCH[2]} ${BASH_REMATCH[1]}
    else
        emacsclient -n $f
    fi
# emacsclient -ne '(gtags-goto-tag "invoke_operation" "")'
done
fi
