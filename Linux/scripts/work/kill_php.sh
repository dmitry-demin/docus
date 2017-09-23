#!/bin/bash
##Kill PHP-process
##houretime - 24*60*60 sec
##current_time - real time your pc


oldifs=$IFS
houretime=86400
current_time=$(date +%s)
dead_time=$[$current_time - $houretime]
php_process=$(ps axwf -o pid -o lstart=START -o command | grep php)

IFS=$'\n'

for i in $php_process
do 
  IFS=$oldifs
  php_pid=$( echo $i| awk '{print $1}' )
  
  php_start=$( date -d "$( ps h -p $php_pid -o lstart=START )" +"%s" )
  echo "php_pid=$php_pid ; php_start=$php_start"

  if [ $dead_time > $php_start ]
  then 
    kill -9 $php_pid
  fi
done
