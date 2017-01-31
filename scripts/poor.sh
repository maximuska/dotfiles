#!/bin/bash
# 'Poor man profiler'

nsamples=5
sleeptime=0

[[ -n "$1" ]] || fatal "Usage: $1 <process name pattern>"

pid=$(pgrep -n $1)
[[ -n "$pid" ]] || fatal "Couldn't match a process"

echo "Now profiling: $(head -n1 /proc/$pid/sched), samples: $nsamples sleep: $sleeptime"

for x in $(seq 1 $nsamples)
  do
    echo -ne "$x\r" > /dev/stderr
    gdb -ex "set pagination 0" -ex "thread apply all bt" -batch -p $pid 2>&1
    sleep $sleeptime
  done | tee -a /tmp/poor.log | \
awk '
  BEGIN { s = ""; }
  /^Thread/ { if (s != "" ) print s; s = ""; }
  /^\#/ { if ($2 ~ /^0x/) { $2=$4 }; if (s != "" ) { s = s ", " $2} else { s = $2 } }
  END { print s }' | \
sort | uniq -c | sort -r -n -k 1,1

function fatal() {
    echo "$@"
    exit -1
}
