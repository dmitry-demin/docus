#!/bin/bash

#
#
#
#   description
#
#
#


#----------------------
# check opts
#----------------------

while getopts ":s:m:d:" Option
do
    case $Option
    in
        m ) m="--exclude=$OPTARG"; var_m="$var_m $m";;
        s ) var_s="$OPTARG";;
        d ) var_d="$DELARG";;
        * ) echo "Ввести переменную";;
    esac
done


# small test
if [ -z "$var_s" ]
then
  echo 'Please enter key and name package, Look --> "-s cacti"'
  exit
fi

#----------------------
# Del old files
#----------------------

rm -f /tmp/webapp_*.txt

#-----------------------
# variables
#-----------------------
check_rsync="/usr/bin/rsync"
eequery="equery -C check"
#otchet_equery_${var_s}-${vers}="/tmp/webapp_otchet-$var_s-$vers.txt"

#-----------------------
# Equery check files
#-----------------------

work_dir=$( webapp-config --li $var_s )
for i in $work_dir
do
  show_work_dir="$i"
  vers="$vers $( grep WEB_PVR= $i/.webapp | cut -d '"' -f 2 )"
done

#-----------------------
#  action
#-----------------------


for i in $vers
do

  # tmp variables
  log_file=$otchet_equery_${var_s}-${i}
  var_exclude="--exclude=\".webapp\" --exclude=\".webapp-${var_s}-${i}\" $var_m"
  base_dir="/usr/share/webapps/$var_s/$i/htdocs/"
  ddd=${show_work_dir}
  # check equery
  $eequery ${var_s}-${i} 2>&1 > $log_file
  $eequery ${var_s}-${i} 2>> $log_file
  # delete settings parametr
  sed -i '/$var_d/d' $log_file
  # check rsync

$check_rsync --dry-run --delete-after -crpogv --out-format="%f %B %c %G %U %M [%i]" $var_exclude $base_dir $ddd >> $log_file
exit
  if [ "$( wc -l $log_file | cut -d' ' -f 1 )" != "1" ]
  then
    echo 'Send'
    echo -e "Subject: `uname`\n\n$( cat $log_file )" | sendmail demin@netville.ru
  fi
done


#----------------------
#   change log
#----------------------




