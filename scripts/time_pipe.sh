#!/bin/bash

if [[ "$*" != "" ]]; then
    print "Usage: <profiled cmd logging to stdout> | $0"
fi

start=$(date "+%s.%N")
while read l; do
    now=$(date "+%s.%N")
    ts=$(echo "print '%.4f' % ($now-$start)" | python)
    echo "$ts: $l"
done
