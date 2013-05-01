#!/bin/bash

sudo bash -c 'i=2; for irq in `seq 75 89`; do printf -v msk "%x" $i; ((i = $i << 1)); if (($i == 128)); then ((i = 2)); fi; echo $msk > /proc/irq/$irq/smp_affinity; done'
