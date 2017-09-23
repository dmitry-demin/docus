#!/bin/bash

##source file2.ini

##
#
#
# Check PID or Service status mysql server
#
#
##

#SERVICE='mysql'
#SOCKET_IS=`ps axwf | grep -v grep | grep mysql | awk '{ print \$13 }'`
#
#if ps axwf | grep -v grep | grep $SOCKET > /dev/null
#then
#    echo "$SERVICE service running, $SOCKET SOCKET found , everything is fine"
#exit
#else
#    if ps axwf | grep -v grep | grep $SERVICE > /dev/null
#        then
#        echo 'Send'
#        echo -e "Subject: `uname -a`\n\n $SERVICE service running, everything is fine, but SOCKET in dir $SOCKET not fount, real socket is $SOCKET_IS" | sendmail demin@netville.ru
#            else
#        echo 'Send'
#        echo -e "Subject: `uname -a`\n\n $SERVICE is not running" | sendmail demin@netville.ru
#    fi
#fi



##
#
#
# Section Global Param
#
#
##

section1=`cat file.ini | grep "^\s*\[.*\]\s*$" | sed 's/\[//g' | sed 's/\]//g'`

for i in $section1; do

function parse()
{
  local _inifile=./file.ini
  local _section=$i
  local _key=$3
  local _socket=socket
  local _user=USER
  local _password=PASSWDDB
  local _bckpdir
   if [ ! -r "$_inifile" ]
   then
     exit 1;
   fi

   exec < $_inifile

   while read section; do
     if [ "$section" = '['$_section']' ] ; then
       IFS='='
       while read key value; do
         # check if we are still within our section
         if [ `echo -n $key | grep "^\s*\[.*\]\s*$"` ]; then
            exit 2;
         fi
         # strip leading and trailing whitespace from keys
         key=`echo -n "$key" | sed 's/^\s*//;s/\s*$//'`
         _key=`echo -n "$_key" | sed 's/^\s*//;s/\s*$//'`
         if [ $key = $_key ]; then
           echo $value
           exit 0;
         fi
      done
    fi
  done
  exit 2;
}
#val=`parse ./file.ini Section2 databases`
#val=`parse $1 $2 $3`
user_mysql=`parse USER`
passwd_mysql=`parse PASSWDDB`
socket_mysql=`parse socket`
bckpdir=`parse bckpdir`

err=$?
if [ $err != 0 ]
  then
     echo "Error: $err"
  fi

blabla=`echo -e $val`
#| sed "s/;/\\`echo -e '\n\r'`/g" > $bckpdir/base.conf
######sed "s/,/\\`echo -e '\n'`/g" > $bckpdir/base.conf

#new_line=`cat $bckpdir/base.conf`

#exit
echo $new_line
echo $user_mysql
echo $passwd_mysql
echo $socket_mysql
echo $bckpdir
done

exit
#adminemail=' demin@netville.ru ' #адрес, на который будут приходить отчеты об архивации

todaydate=`date "+%d-%m-%Y"`
#first_day=`date "+01-%m-%Y"` #Если сегодня 1 число не удаляем файл

for i in $blabla
do /usr/bin/mysqldump --skip-opt -R -Q --add-locks -u$user_mysql --password=$passwd_mysql -S$socket_mysql $i > $bckpdir/$i.sql | gzip -c > "$bckpdir/$todaydate.$i.gz"
#--databases $i > $bckpdir/$i.sql | gzip -c > "$bckpdir/$todaydate.$i.gz"
done

exit
# Создаем архив с дампами мускульных баз.
# Использовать "tar -xzf archivename.tar" для распаковки
cd $bckpdir

tar -czf $todaydate.mysqldump.tar *.gz


# Отсылка на почту админу списка файлов в $bckpdir. Тут используется переменная $adminemail
#ls -l $bckpdir/*.sql $bckpdir/*.tar | awk '{print ($5,$8,$9)}' | sort -n -r | mail -s "BACKUP.GW.MySQL" $adminemail

# Очищаем директорию с бэкапами от незаархивированных баз
rm -Rf $bckpdir/*.sql
rm -Rf $bckpdir/*.gz
#rm -Rf $bckpdir/$bckplist

# Удаляем архивы старше 7 дней
find $bckpdir -name \*.tar -mtime +7 -delete
find $bckpdirsite -name \*.tar -mtime +7 -delete

