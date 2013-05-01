#!/usr/bin/env python

import sys
import struct
from time import ctime

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print >>sys.stderr, "Usage: %s <trace with samples of dev/uproc/nas_block_ios>"
        sys.exit(-1)
    fl = sys.argv[1]

TRACE_REC_STRUCT = '=hhQQQII'

TRACE_HEADER = "Date,                  nBlocks, OP,            LBA,             Time,          Vol, *I, Latency(us)"
print TRACE_HEADER
with file(fl) as f:
    while True:
        block = f.read(struct.calcsize(TRACE_REC_STRUCT))
        if len(block) != struct.calcsize(TRACE_REC_STRUCT):
            if len(block) != 0:
                print >>sys.stderr, "WARNING: unexpected leaftovers in the tracefile: %r" % block
            break

        nBlock, isRead, lba, time, vol, drop, latency = struct.unpack(TRACE_REC_STRUCT, block)
        print "%s, %4d, %2s, %14d, %12d, %12X, %2d, %5d" % (ctime(time/1e6), nBlock, ("R" if isRead else "W"), lba, time, vol, drop, latency)
print TRACE_HEADER
