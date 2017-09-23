#!/bin/bash

#sudo ps aux | grep demin | grep -v grep | wc -l > demin.txt #### ps aux | grep -game server

### sudo cat /home/demin/scripts/bash/develop/demin2.txt ##### /etc/rc.local

#test1=`cat demin.txt`
#test2=`cat demin2.txt`
#check="35"

#if [ "$test1" = "$test2" ]; then
#    echo "Correct $test2"
else
    echo "Bad sum $test2"
    exit
fi

#if [ "$test" = "$check" ]; then
#    echo "Goood !! $check"
#else
#    echo "Warning, sum is not correct $test != $check"
#exit
#fi

for i in [ "$test1" = "$check" ]; do
    echo "if sum correct"
        rm -f /home/demin/scripts/bash/develop/demin.txt
done


