#!/bin/bash
for i in `cat hosts`
do
        echo " Current swap utilization on "$i" is"
        ssh -q  $i <<EOF

echo "Swap utilization values: "
echo " "
free -g
echo "Top memory consuming processes: "
echo ""
top -b -o +%MEM -n 1 | head -n 12 | tail -n 5
EOF
done
