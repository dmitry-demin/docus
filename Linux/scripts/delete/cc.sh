#!/bin/bash -x

base_dir='/usr/share/webapps/cacti/0.8.7i/htdocs/'
work_dir='/var/www/cacti.test.dm/htdocs/cacti/'

check_rsync="/usr/bin/rsync"

log_pars="/tmp/log_event.txt"
log_pars1="/tmp/log_event1.txt"

equery check cacti 2>&1 > $log_pars1
equery check cacti 2>> $log_pars1

$check_rsync --dry-run --delete-after -crpogv --out-format="%f %B %c %G %U %M [%i]" --exclude='*.rrd' --exclude='.webapp*' $base_dir $work_dir > $log_pars

sed -i -e :a -e 's/^.\{1,78\}$/ &/;ta' $log_pars

cat /tmp/log_event1.txt >> /tmp/log_event2.txt

#echo "Check log in attache" mutt -s “Cacti Log” demin@netville.ru < /tmp/log_event.txt

#echo 'Check log in attache' | sendmail demin@netville.ru < /tmp/log_event2.txt

#rm -r /tmp/log_event*

