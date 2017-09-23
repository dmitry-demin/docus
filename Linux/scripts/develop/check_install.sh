#!/bin/bash

DIR1="/var/www/cacti.test.dm/htdocs/cacti/"
DIR2="/usr/share/webapps/cacti/0.8.7i/htdocs/"

for i in `ls $DIR1 $DIR2 | grep -v $DIR1 | grep -v $DIR2 | sort | uniq -c | grep " 2 " | awk '{print $2}'

    do 
        echo "diff for $DIR1/$i $DIR2/$i"
        comm -3 $DIR1/$i $DIR2/$i
done 

























































#heck_install="/usr/bin/qlist -IC"
#№where_install="whereis"
#locate_install="qfile -f testing1"

#        echo "-----------------------------------TEST---------------------------------------"

#$check_install | gawk -F/ '{print $2}' >> testing1

#$locate_install

#rm -rf testing1

#$where_install 

