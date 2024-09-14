#!/bin/bash
#purpose: To verify multiple parameters in single script
#author: Sampath

echo " 1. Select to view disk utilization "
echo " 2. Select to view CPU utilization"
echo " 3. Select to view Swap utilization"

echo -e " please select an option :\c" #echo -e is used for passing extended options
read -r ch # Stores the selected option in ch
case $ch in
        1)
                DISK=`df -h /var | tail -n 1 | awk '{print $5}' | sed 's/%/ /g'`
                #tail -n 1 will cut the first line
                # awk '{print $5}' will give 5th field output
                # sed 's/%/ /g' replacing % value with space
if [ $DISK -gt 90 -a $DISK -lt 98 ] ; then

        echo " /Var utilization for `hostname` is high"
else
        echo " /Var utilization for $(hostname) is low"
fi ;;
        2)
                top -b n1 | head -n 10 > /tmp/cpuusage
                # -b used for batch-mode(non interactive mode)
                # n1 executes script once and exit
                # head -n 10 will print first 10 lines of output
CPU_user=$(cat /tmp/cpuusage | grep "%Cpu(s)" | awk '{print $2}'| cut -d '.' -f 1)
# cut -d '.' -f 1 split decimal values into two parts and print first part
if  [ $CPU_user -gt 80 -a $CPU_user -lt 90  ];
then
        echo "Warning for CPU"

elif [ $CPU_user -gt 90 -a $CPU_user -lt 98 ];
then
        echo " CRITICAL for CPU"
else
        echo " Normal for CPU"
fi ;;
         3)
                 SWAP=`free -g | tail -n 1 | awk '{print $4}'`
if [ $SWAP -lt 1 ]; then
        echo " SWAP utilization is very low"
else
        echo " swap is good"
fi;;
esac
