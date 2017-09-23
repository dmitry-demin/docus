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

function parse()
{
  local _inifile=$1
  local _section=$2
  local _key=$3
  local _socket=socket
  local _user=USER
  local _password=PASSWDDB

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
         #SOCKET USE
#         if [ `echo -n $socket | grep "^\s*\[.*\]\s*$"` ]; then
#            exit 2;
#         fi
#         socket=`echo -n "$socket" | sed 's/^\s*//;s/\s*$//'`
#         _socket=`echo -n "$_socket" | sed 's/^\s*//;s/\s*$//'`
#         if [ $socket = $_socket ]; then
#            echo $socket
#           exit 0;
#         fi
#         #USER NAME
#         _user=`echo -n "$_user" | sed 's/^\s*//;s/\s*$//'`
#         if [ $user = $_user ]; then
#            echo $user
#           exit 0;
#         fi
#         #PASSWD USER
#         _password=`echo -n "$_password" | sed 's/^\s*//;s/\s*$//'`
#         if [ $password = $_password ]; then
#            echo $password
#           exit 0;
#         fi
      done
    fi
  done
  exit 2;
}
#val=`parse ./file.ini Section2 databases`
val=`parse $1 $2 $3`
user_mysql=`parse $1 $2 USER`
passwd_mysql=`parse $1 $2 PASSWDDB`
socket_mysql=`parse $1 $2 socket`


err=$?
if [ $err != 0 ]
  then
     echo "Error: $err"
  fi

echo $val
echo $user_mysql
echo $passwd_mysql
echo $socket_mysql
##echo password

#exit

#bckpdir='/opt/backup/mysqlbackup' #директория в которую будут делаться бэкапы баз
#bckplist='mysql_databases_list.txt' #список баз мускула
#bckppath=$bckpdir/$bckplist #полный путь к файлу со списком баз для бэкапа
#passwd_root_mysql='j[etnm' #пароль рута для доступа к базе
#socket='/var/run/mysqld/mysqld2.sock'

#adminemail=' demin@netville.ru ' #адрес, на который будут приходить отчеты об архивации

todaydate=`date "+%d-%m-%Y"`
#first_day=`date "+01-%m-%Y"` #Если сегодня 1 число не удаляем файл

# Проверка, существует ли папка для бэкапов. Если да,то печатает "Dir exist", если нет, то создает $bckpdir (см. первый параграф)
if test -d $bckpdir
then
echo "Dir exists" > /dev/null
else
mkdir -p $bckpdir
fi

if test -d $bckpdirsite
then
echo "Dir exists" > /dev/null
else
mkdir $bckpdirsite
fi


# В общем, заходим в базу под рутом "/bin/mysql -u root",
#печатаем "show databases;" и вытаскиваем "sed '1,1d'" названия баз мускула. Вывод перенаправляем в файл $bckppath.
#echo "show databases;" |
#/usr/bin/mysql -u ${USER} --password=${passwd_root_mysql} -S $SOCKET --databases $val

#| sed '1,1d' > $bckppath

# Переменной parse ставим значение "cat $bckppath", она будет перечислять построчно в цикле каждую строчку файла $bckppath
#Далее делаем цикл, с присвоением переменной i значений из $parse и подстановкой в
#/bin/mysqldump --databases $i > $bckpdir/$i.sql
#То есть под $i подразумевается название базы данных из строчки $bckppath.
#sudo sed -i 's/information_schema//g' $bckpdir/$bckplist
#sudo sed -i 's/mysql//g' $bckpdir/$bckplist

#parse=`cat $bckppath`


#Далее делаем отдельно бэкап каждой базы, на случай, если крякнет одна из баз.
#/usr/bin/mysqldump --skip-opt -R -Q --add-locks -u root --password=${passwd_root_mysql} --all-databases > $bckpdir/all-databases.sql

for i in $val
do /usr/bin/mysqldump --skip-opt -R -Q --add-locks -u$user_mysql --password=$passwd_mysql -S$socket_mysql --databases $i > $bckpdir/$i.sql | gzip -c > "$bckpdir/$todaydate.$i.gz"
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

