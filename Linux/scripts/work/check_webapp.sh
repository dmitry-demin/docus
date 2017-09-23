#!/bin/bash

#---------------------------------------------------------------------------------------------
#
#
#           File: check_webapp.sh
#
#
#          Usage: check_webapp.sh [-s] [-m] [-d]
#
#
#    Description: Check Webapp-config package and check equery md5sum, after check complite
#                 you get email verification that the test was successful or there were
#                 changes in the file or md5sum.
#
#
#
#        Options: see function `usage`
#
#           Bugs: ---
#           Note: ---
#         Author: Demin Dmitry
#        Company: Netville
#
#        Version: 1.0
#        Created: 08/12/2012 - 12/12/2012
#
#
#
#---------------------------------------------------------------------------------------------

while getopts ":s:m:d:" Option
do
    case $Option
    in
        m ) m="--exclude=$OPTARG"; var_m="$var_m $m";;
        s ) var_s="$OPTARG";;
        d ) var_d="$OPTARG $var_d";;
        * ) echo "Ввести переменную";;
    esac
done

# small test
if [ -z "$var_s" ]
then
  echo 'Please enter key and name package.'
  echo 'FOR Example: "-s cacti", if you want to Exclude files press key "-m" and enter name ".webapp"'
  echo 'and are you need to delete in logfile or filename, enter key "-d" and file name "settings.php"'
  exit
fi

#----------------------
# Del old files
#----------------------
rm -f /tmp/webapp_*
#-----------------------
# variables
#-----------------------
check_rsync="/usr/bin/rsync"
eequery="equery -C check"

  log_var="/tmp/webapp_dir"
for i in $( webapp-config --li $var_s )
do
  vers="$( grep WEB_PVR= $i/.webapp | cut -d '"' -f 2 )"
  log_file="/tmp/webapp_${var_s}-${vers}"
  var_exclude="--exclude=.webapp --exclude=.webapp-${var_s}-${vers} $var_m"
  base_dir="/usr/share/webapps/$var_s/$vers/htdocs/"

  # Equery check
  $eequery ${var_s}-${vers} 2>&1 > $log_file
  $eequery ${var_s}-${vers} 2>> $log_file
  # delete settings in log
  for del in $var_d
  do
    fdel=$( echo "$del" | sed 's/\//\\\//g' )
    sed -i "/$fdel/d" $log_file
  done
  # Rsync check

  $check_rsync --dry-run --delete-after -crpog --out-format="%f %B %c %G %U %M [%i]" $var_exclude $base_dir $i >> $log_file

exit
  if [ "$( wc -l $log_file | cut -d' ' -f 1 )" != "1" ]
  then
    echo 'Send'
    echo -e "Subject: `uname -a`\n\n$( cat $log_file )" | sendmail demin@netville.ru
  fi
done

#------------------------------------------------
# Latest cange                                  |
#------------------------------------------------
#                             |                 |
#  sed delete slash directory |  17.12.2012     |
#-----------------------------------------------|
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#------------------------------------------------
