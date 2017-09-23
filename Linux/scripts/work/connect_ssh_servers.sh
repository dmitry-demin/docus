#!/bin/bash

if [ "$1" == '' ]
then
  echo "Parametres not found! Exit!"
  exit
elif [ "$1" != 'full' ] && [ "$1" != 'custome' ] && [ "$1" != 'mysqlnonwork'] && [ "$1" != 'mysqlwork']
then
  echo "Parametres not found! Exit!"
  exit
fi


server_list_full="
s1-pstar-spb
s2-pstar-spb
s3-pstar-spb
s4-pstar-spb
s1-szt-arkhangelsk
s2-szt-arkhangelsk
s3-szt-arkhangelsk
s4-szt-arkhangelsk
s5-szt-arkhangelsk
s1-szt-koenig
s2-szt-koenig
s3-szt-koenig
s4-szt-koenig
#s1-szt-komi
#s2-szt-komi
#s3-szt-komi
#s4-szt-komi
s1-szt-lenobl
s2-szt-lenobl
s3-szt-lenobl
s4-szt-lenobl
s3-szt-murmansk
s4-szt-murmansk
s5-szt-murmansk
s1-szt-nov
s2-szt-nov
s3-szt-nov
s4-szt-nov
s1-szt-spb
s2-szt-spb
s3-szt-spb
s4-szt-spb
s5-szt-spb
s6-szt-spb
s7-szt-spb
s9-szt-spb
s10-szt-spb
s1-tkt-spb
s2-tkt-spb
s3-tkt-spb
s4-tkt-spb
"
server_list_custome="
s1-szt-arkhangelsk
s2-szt-arkhangelsk
s3-szt-arkhangelsk
s4-szt-arkhangelsk
s5-szt-arkhangelsk
"


server_list_mysqlnonwork="
s1-pstar-spb.netville.ru
s2-pstar-spb.netville.ru
s4-pstar-spb.netville.ru
s1-szt-arkhangelsk.netville.ru
s2-szt-arkhangelsk.netville.ru
s4-szt-arkhangelsk.netville.ru
s5-szt-arkhangelsk.netville.ru
s1-szt-koenig.netville.ru
s2-szt-koenig.netville.ru
s4-szt-koenig.netville.ru
s1-szt-komi.netville.ru
s2-szt-komi.netville.ru
s4-szt-komi.netville.ru
s1-szt-lenobl.netville.ru
s2-szt-lenobl.netville.ru
s4-szt-lenobl.netville.ru
s4-szt-murmansk.netville.ru
s5-szt-murmansk.netville.ru
s1-szt-nov.netville.ru
s2-szt-nov.netville.ru
s4-szt-nov.netville.ru
s1-szt-spb.netville.ru
s2-szt-spb.netville.ru
s3-szt-spb.netville.ru
s6-szt-spb.netville.ru
s7-szt-spb.netville.ru
s9-szt-spb.netville.ru
s10-szt-spb.netville.ru
s1-tkt-spb.netville.ru
s2-tkt-spb.netville.ru
s4-tkt-spb.netville.ru
"

server_list_mysqlwork="
s3-tkt-spb.netville.ru
s5-szt-spb.netville.ru
s4-szt-spb.netville.ru
s3-szt-nov.netville.ru
s3-szt-murmansk.netville.ru
s3-szt-komi.netville.ru
s3-szt-lenobl.netville.ru
s3-szt-arkhangelsk.netville.ru
s3-pstar-spb.netville.ru
s3-szt-koenig.netville.ru
"


eval server_list='$server_list'_$1

for i in $server_list
do
  echo "===================== START $i ========================"
  scp -o StrictHostKeyChecking=no ls.sh ${i}:
  ssh -A -o StrictHostKeyChecking=no $i './ls.sh; rm -f ls.sh'
  echo "===================== END $i =========================="
done
