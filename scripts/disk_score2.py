#!/usr/bin/python

# Scipt by Tomer G, classifying disks by various parameters.

import subprocess
import re
import os, sys

_verbose = 0
def V(message):
    if not _verbose:
        return
    print >>sys.stderr, "** ", message

all_disks=list()
for m in range(1,16):
        V("%d" % (m,))
        if os.system("ping module-%s -w 1 &> /dev/null"%(m)) == 0:
                pstats=subprocess.Popen("xcli.py disk_list module=1:module:%d|cut -d\":\" -f4-|sort -n"%(m),shell=True,stdout=subprocess.PIPE).communicate()[0]
                disk_ids=list(int(r.split()[0]) for r in pstats.splitlines()[2:])
                dstatus=list(r.split()[1] for r in pstats.splitlines()[2:])
                pstats=subprocess.Popen(["ssh","module-%s"%(m),"/xiv/tools/sas_stats_reader 7 |tail -n4"],stdout=subprocess.PIPE)
                lats=(pstats.communicate()[0]).splitlines()
                pstats=subprocess.Popen(["ssh","module-%s"%(m),"/xiv/tools/scsi_test/sas-disks-logs.py --all|grep R_"],stdout=subprocess.PIPE)
                rerrors=[ r.split() for r in (pstats.communicate()[0]).splitlines()]
                del lats[0]
                bins =len(lats)
                disks=[]
                for bin,lat in enumerate(lats):
                    bin_lats=re.findall(r'(\d+)/(\d+)/(\d+)',lat)
                    for d,dlats in enumerate(bin_lats):
                        mult=2 if lat[0]==">" else 1
                        disk_score=(int(dlats[0])+int(dlats[1]))*((int(re.search(r'\d+', lat).group())*mult)**3/(10**9))
                        try:
                             disks[d]+=disk_score
                        except :
                             disks.append(disk_score)
                V("disk ids %r" % (disk_ids,))
                V("disks scores %r" % (disks,))
                V("dstatus %r" % (dstatus,))
                V("rerrors3 %r" % (rerrors[3],))
                V("rerrors9 %r\n" % (rerrors[9],))
                # 'disks' - scores for 12 disks, missing disks are scored '0'
                # 'rerrors[xxx]' - List with disks statistics. Missing disks are skipped.
                all_disks.extend([(str(m)+':'+str(disk_id),disks[disk_id-1],int(rerrors[3][d+1]),int(rerrors[9][d+1]),dstatus[d]) for d, disk_id in enumerate(disk_ids)])

V("")
print 'disk_id\t\tlatency_score\tR_rec_w_delay\tR_unrecovered\tstatus'
for d in sorted(all_disks, key=lambda x: x[1],reverse=True):
        def print_disk(d):
#               suffix=''
#               if d[1] > 2000:
#                       suffix=' replace'
#               if d[1] > 1000:
                print '\t\t'.join([str(ds) for ds in d])
        print_disk(d)
