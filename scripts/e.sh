#!/bin/bash 

if ! emacsclient -e t >/dev/null 2>&1  
then
    exec emacs "$@" &
else
#echo emacsclient -n "$@"
for f in "$@"; do emacsclient -n $f; done
#exec emacsclient -n "$@"
fi
