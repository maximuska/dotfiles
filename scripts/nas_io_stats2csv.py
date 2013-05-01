#!/usr/bin/env python

import re
import sys

def iterate_blocks(fl, ankor):
    in_blk = False
    acc = list()
    for line in file(fl):
        if line.startswith(ankor):
            if in_blk and acc:
                yield "".join(acc)
            in_blk = True
            acc = list()
        acc.append(line)
    # Output the last block
    if in_blk and acc:
        yield "".join(acc)

BLK_START_ANKOR = 'System time'
COLUMNS = (
    'msec', 'date', 'outstanding_ios', 'outstanding_wios',
    'ios', 'wios', 'blk', 'wblk', 'acc_latency', 'wacc_latency', 'ios_hit', 'ios_hit_write',
    'ios_4k', 'wios_4k', 'blk_4k', 'wblk_4k', 'acc_latency_4k', 'wacc_latency_4k', 'ios_hit_4k', 'ios_hit_write_4k',
    'ios_64k', 'wios_64k', 'blk_64k', 'wblk_64k', 'acc_latency_64k', 'wacc_latency_64k', 'ios_hit_64k', 'ios_hit_write_64k',
    )

BLK_EXAMPLE = \
"""System time (ms): 1359134531295 (Jan 09 17:36:40)

Outstanding ios:         0
Outstanding write ios:   0

*** All ***             total        inc    1e3/sec
ios:                     6010         +0        0.0
ios_write:               5749         +0        0.0
blocks:                456876         +0        0.0
blocks_write:          454183         +0        0.0
latency:              4017073         +0
latency_write:        3792060         +0
ios_hit:                 5980         +0        0.0
ios_hit_write:           5719         +0        0.0

*** 4K- ***             total        inc    1e3/sec
ios:                      455         +0        0.0
ios_write:                201         +0        0.0
blocks:                   474         +0        0.0
blocks_write:             213         +0        0.0
latency:               384076         +0
latency_write:         162678         +0
ios_hit:                  425         +0        0.0
ios_hit_write:            171         +0        0.0

*** 64K+ **             total        inc    1e3/sec
ios:                       67         +0        0.0
ios_write:                 66         +0        0.0
blocks:                137216         +0        0.0
blocks_write:          135168         +0        0.0
latency:               429838         +0
latency_write:         427685         +0
ios_hit:                   67         +0        0.0
ios_hit_write:             66         +0        0.0
"""

BRE = re.compile(r"""^System time.*:\s+(?P<%s>\d+) (?P<%s>\(.*\)).*

^Outstanding ios:\s+(?P<%s>\d+).*
^Outstanding write ios:\s+(?P<%s>\d+).*

^\*\*\* All \*\*\*.*
^ios:\s+(?P<%s>\d+).*
^ios_write:\s+(?P<%s>\d+).*
^blocks:\s+(?P<%s>\d+).*
^blocks_write:\s+(?P<%s>\d+).*
^latency:\s+(?P<%s>\d+).*
^latency_write:\s+(?P<%s>\d+).*
^ios_hit:\s+(?P<%s>\d+).*
^ios_hit_write:\s+(?P<%s>\d+).*

^\*\*\* 4K- \*\*\*.*
^ios:\s+(?P<%s>\d+).*
^ios_write:\s+(?P<%s>\d+).*
^blocks:\s+(?P<%s>\d+).*
^blocks_write:\s+(?P<%s>\d+).*
^latency:\s+(?P<%s>\d+).*
^latency_write:\s+(?P<%s>\d+).*
^ios_hit:\s+(?P<%s>\d+).*
^ios_hit_write:\s+(?P<%s>\d+).*

^\*\*\* 64K\+ \*\*.*
^ios:\s+(?P<%s>\d+).*
^ios_write:\s+(?P<%s>\d+).*
^blocks:\s+(?P<%s>\d+).*
^blocks_write:\s+(?P<%s>\d+).*
^latency:\s+(?P<%s>\d+).*
^latency_write:\s+(?P<%s>\d+).*
^ios_hit:\s+(?P<%s>\d+).*
^ios_hit_write:\s+(?P<%s>\d+).*
""" % COLUMNS, re.M)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print >>sys.stderr, "Usage: %s <log with samples of /dev/uproc/nas_block_ios>"
        sys.exit(-1)
    fl = sys.argv[1]

    # (Sanity) match the 'EXAMPLE' first..
    match = re.match(BRE, BLK_EXAMPLE)
    if not match:
        print "Error parsing example, fix me:", sys.argv[0]
        sys.exit(-1)

    # Process log
    print ",".join(COLUMNS)
    for block in iterate_blocks(fl, BLK_START_ANKOR):
        match = re.match(BRE, block)
        if match:
            print ','.join(match.groups())
    print ",".join(COLUMNS)
