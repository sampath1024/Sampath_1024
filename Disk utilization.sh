#!/bin/bash
#purpose: To check disk utilization and send mail
#author: Sampath
DISK=`df -h /var | tail -n 1 | awk '{print $5}' | sed 's/%/ /g'`
if [ $DISK -gt 12 -a $DISK -le 15 ] ; then

        echo " Disk utilization for `hostname` is high"
else
        echo " disk utilization for $(hostname) is low"
fi




