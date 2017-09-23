#!/bin/bash


todaydate=$(date "+%Y%m%d")
onedaydate=$(date "+%Y%m01")
config_file="$1"
OLDIFS=$IFS
END=END

#Check services status

    if [ -f "$config_file" ]
    then

#mailcmd=$(which mail)

#mailcmd=$( echo 'Warrning' | sendmail demin@netville.ru < $sendmessage )


#sendmessage="/tmp/warning"
#email_addr="demin@netville.ru"
MysqlServices=$(ps aux | grep mysql | grep -v grep| wc -l)
StunnelServices=$(ps aux | grep stunnel | grep -v grep| wc -l)
RsyncServices=$(ps aux | grep rsync | grep -v grep| wc -l)

#        mail_send()
#        {
#            if [ $mailcmd ]
#            then
#                 $mailcmd -s "Error server `uname -a` services not runnung" $email_addr < $sendmessage
#            fi
#        }

        _logger()
        {
            echo "$@"
            echo "$@" >> sendmessage
        }

        check_services()
        {
        _result=$( ps aux | grep $1 | wc -l )
            if [[ _result -eq 0 ]]
            then
                _logger "Error"
                _logger "This services $1 not starting"
                _logger "Services check date today $(date +"%d.%m.%y %H:%M:%S", im tryin services start)"
                /etc/init.d/$1 start
                sleep 2
                _logger "Now check services"
                _result=$( ps aux | grep $1 | wc -l )
                if [[ _result -eq 0 ]]
                then
                _logger "Error"
                _logger "This services $1 not run"
                else
                _logger "This services $1 run"
                fi
            fi
        }

                _logger "This mail send you"
                _logger "$(hostname), check services"
                _logger "----------------------------------------"
                _logger ""

                check_services "$MysqlServices"
                check_services "$StunnelServices"
                check_services "$RsyncServices"

        if [ $MysqlServices -eq 0 ] || [ $StunnelServices -eq 0 ] || [ $RsyncServices -eq 0 ]
        then
            mail_send
        fi

#Remove Service Log file
rm -f $sendmessage
fi
exit
else

#echo "$config_file"

for i in $( grep '^\[' $config_file )
do
    section=${i/[/\\[}
    section=${section/]/\\]}

       IFS=$'\n'
           for b in $( sed -n "/$section/"',$p' $config_file | grep -v $section )
           do

           if [ ${b:0:1} = ';' ]
           then
              continue 2
           else
              if [ ${b:0:1} != '[' ]
              then
              param=_${b}
                 eval $param > /dev/null 2>&1
                 else
                 for database in ${_databases[@]}
                 do
                   if [ "$section" != '\['$END'\]' ]
                   then
                       mkdir -p ${_backupdir}
                       bash -c "mysqldump -R -u $_user -p$_pass -S $_socket ${database} > ${_backupdir}/${todaydate}_${database%% *}.sql"
                       gzip -c ${_backupdir}/${todaydate}_${database%% *}.sql > ${_backupdir}/${todaydate}_${database%% *}.gz
                       tar -rpf ${_backupdir}/${todaydate}.${i:1:-1}.tar ${_backupdir}/${todaydate}_${database%% *}.gz
                       rm ${_backupdir}/${todaydate}_${database%% *}.sql
                       rm ${_backupdir}/${todaydate}_${database%% *}.gz
                   fi
                   done
                   if [ "$( date --date="8 day ago" +%Y%m%d )" = "${onedaydate}" ] && [ -f ${_backupdir}/${onedaydate}.${i:1:-1}.tar ]
                   then
                      test -d ${_backupdir}/${onedaydate} || mkdir -p ${_backupdir}/${onedaydate}
                      mv ${_backupdir}/${onedaydate}.${i:1:-1}.tar ${_backupdir}/${onedaydate}
                   fi
           if [ -f ${_backupdir}/${todaydate}.${i:1:-1}.tar ] && [ -n $_rspass ] && [ -n $_rsuser ] && [ -n $_rshost ]
           then
              rsync -avR ${_backupdir}/${todaydate}.${i:1:-1}.tar --password-file=$_rspass $_rsuser@$_rshost::backup
              break
                 fi
           fi
           fi
           done
done

            find $dir_back -maxdepth 1 -type f -name "*" -mtime +8 -exec rm -f {} \;

fi
