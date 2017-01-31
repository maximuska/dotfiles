#!/bin/bash
LOGFILE=$1
DISK=$(printf %02d ${2:-0})
#RW="READ"
RW="WRITE"
#RW=".*"
echo Stats for disk: $DISK, req type: $RW
printf "%18s %11s %8s %8s %11s\n" "Time" "BW" "IOPs" "Lrg IOPs" "Misaligned"
egrep "SAS.DISK.$DISK.*$RW request" $LOGFILE | awk '{sub(":..\..*","",$1); print $1,$17,$15;}' | \
    awk '{a[$1]+=$2; b[$1]+=1; c[$1, ($3 % 8) + ($2 % 8)]+=1; $2 >= 1024 && large[$1]+=1 } \
        END{for(i in a)printf("%s: %5.1f MB/s %4d IOPs %4d lIOPs %6.1f%%\n", i,a[i]/2048/60, b[i]/60, large[i]/60, (1.0 - c[i,0]/b[i])*100) ;}' | sort
