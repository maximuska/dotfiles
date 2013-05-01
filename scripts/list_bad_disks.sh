#!/bin/bash

event_proc.py -s maj | grep -e DISK_EXCESSIVE_BMS_ACTIVITY -e DISK_HIGH_READ_CORRECTED_WITH_DELAY_RATE | perl -ne '/(1:Disk:\d+:\d+)/ && print "$1\n"' | sort -u
