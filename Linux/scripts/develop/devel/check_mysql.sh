#!/bin/bash


todaydate=$(date "+%Y%m%d")
onedaydate=$(date "+%Y%m01")
config_file="$1"
OLDIFS=$IFS
END=END

#MysqlServices=$(ps aux | grep mysql | grep -v grep| wc -l)
#StunnelServices=$(ps aux | grep stunnel | grep -v grep| wc -l)
#RsyncServices=$(ps aux | grep rsync | grep -v grep| wc -l)

#function _check {
#    "$@"
#    _status=$?
#    if [ $_status -ne 0 ]
#    then
#        echo "$_status"
#    fi
#    return $_status
#}

if [ -f "$config_file" ]
 then
    for i in $( grep '^\[' $config_file )
    do
    section=${i/[/\\[}
    section=${section/]/\\]}
       IFS=$'\n'
           for b in $( sed -n "/$section/"',$p' $config_file | grep -v $section )
           do

echo $b
done
exit 1;


       if [ ${b:0:1} = ';' ]
       then
          continue 2;
       else
       if [ ${b:0:1} != '[' ]
        then
             param=_${b}
                 eval $param > /dev/null 2>&1
                 else

           echo "Check mysql status"
           function _check
           {
             "$@"
            _status=$?
            if [ $_status -ne 0 ]
             then
           echo -e "Subject: `uname` service mysql\n\n $( echo Access denied in `hostname`.netville.ru then section $section for user $_user or password $_pass and check the socket $_socket )" | sendmail $_email_addr
            fi
           #    return $_status
           }
           $(_check mysql -u $_user -p$_pass -S $_socket -e ";")
                 for database in ${_databases[@]}
                 do
                   if [ "$section" != '\['$END'\]' ]
                   then
                       mkdir -p ${_backupdir}
                       bash -c "mysqldump -R -u $_user -p${_pass} -S $_socket ${database} > ${_backupdir}/${todaydate}_${database%% *}.sql"
                       gzip -c ${_backupdir}/${todaydate}_${database%% *}.sql > ${_backupdir}/${todaydate}_${database%% *}.gz
                       tar -rpf ${_backupdir}/${todaydate}.${i:1:-1}.tar ${_backupdir}/${todaydate}_${database%% *}.gz
                       rm ${_backupdir}/${todaydate}_${database%% *}.sql
                       rm ${_backupdir}/${todaydate}_${database%% *}.gz
                   fi
                   done
#                   if [ "$( date --date="8 day ago" +%Y%m%d )" = "${onedaydate}" ] && [ -f ${_backupdir}/${onedaydate}.${i:1:-1}.tar ]
#                   then
#                      test -d ${_backupdir}/${onedaydate} || mkdir -p ${_backupdir}/${onedaydate}
#                      mv ${_backupdir}/${onedaydate}.${i:1:-1}.tar ${_backupdir}/${onedaydate}
#                   fi
#           if [ -f ${_backupdir}/${todaydate}.${i:1:-1}.tar ] && [ -n $_rspass ] && [ -n $_rsuser ] && [ -n $_rshost ]
#           then
#              rsync -avR ${_backupdir}/${todaydate}.${i:1:-1}.tar --password-file=$_rspass $_rsuser@$_rshost::backup
              break
#                 fi
        #   fi
           fi
           fi
           done
#    done

#            find $dir_back -maxdepth 1 -type f -name "*" -mtime +8 -exec rm -f {} \;

else
    echo "file not exits, please enter configuration file"

fi