xcli.py disk_list | perl -ne '/(1:Disk:\d+:\d+)/ && print "$1\n"' > /tmp/1
for i in {1..15}; do for j in {1..12}; do echo "1:Disk:$i:$j"; done; done > /tmp/2
sort /tmp/{1,2} | sort | uniq -u
