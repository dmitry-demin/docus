#!/bin/bash

todaydate=$(date "+%Y%m%d")
config_file='conf.ini'
dir_back="/tmp/backup/"
OLDIFS=$IFS

section_dis=$( grep '^\;\[' $config_file )

echo $section_dis

for i in $( grep '^\[' $config_file )
do
    section=${i/[/\\[}
    section=${section/]/\\]}

        echo "###########################################################"
        echo $section
        echo "$i"
        echo "$section_dis"
        echo "###########################################################"

if [ $section = ";$section" ]
    then

    echo " $section = ;$section "

else
    IFS=$'\n'
    for b in $( sed -n "/$section/"',$p' $config_file | grep -v $section )
    do

        echo $b

#    if [ $b -eq "^;" ]
#        then
#        echo ############################################################
#        echo $section = _; check
#        echo ############################################################

#        contionue 1
#    else
        if [ ${b:0:1} = ';' ]
            then
                continue 2
            else
                if [ ${b:0:1} != '[' ]
                then
                    param=_${b}
                    eval $param > /dev/null 2>&1
                    else
                    echo "======"
                    for database in ${_databases[@]}
                    do
#                       if [ -d = "${_backupdir}" ]; then
                        echo   "mkdir -p ${_backupdir}"
#                else
#                echo "mysqldump -R -u $_user -p $_pass -s $_socket $database > ${_backupdir}/${todaydate}_${database%% *}.sql"
#                echo "gzip -c ${_backupdir}/${todaydate}_${database%% *}.gz"
#                fi
            done
            break
        fi
    fi
    done
fi
done
exit

            echo "delete file=========="
            echo "find $dir_back -name \*.tar -mtime 7 --delete"
            echo "tar ================="
            for backup in $( ls $dir_back );do
                echo "tar -czf $todaydate.$backup.mysqldump.tar"
            done
