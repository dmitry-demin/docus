#!/bin/bash

SITE="http://freelist.virussign.com/freelist/ http://samples.virussign.com/samples/"
USER="f_e.kaluzhnaya:fkSk3kdSk8"
DOWNLOAD="/var/www/.download_files"
LOCATION="/etc/default/.download_files"
SAVE_FILES="/var/www/virussign.avsw.ru/files/"
CHECK_PID=`ps aux | grep "download_virussign.com.sh" | grep -v grep | wc -l`

if [ ${CHECK_PID} -le 2 ]
  then
find ${SAVE_FILES} -type f -empty -exec rm -rf {} \;

for a in `echo ${SITE}`; do
  curl -l ${a} -u${USER} 2>&1 | egrep -o 'VirusSignList_Free_[0-9+]+.zip|virussign.com_[0-9]+_Free.zip|password.html|#ZIP Password [virussign].txt' | sort | uniq | tee ${DOWNLOAD}

if [ -f ${LOCATION} ]
then
  for i in `cat ${DOWNLOAD}`
  do
                egrep -o ${i} ${LOCATION}
                if [ $? -ge 1 ]
                then
                        curl -O -L ${a}${i} -u${USER}
                        _sed=`echo ${i} | sed -e 's/_Free//g'`
                        if [ -d ${SAVE_FILES} ]
                        then
                        mv ${i} ${SAVE_FILES}${_sed}
                          else
                        mkdir -p ${SAVE_FILES}
                        mv ${i} ${SAVE_FILES}${_sed}
                        fi
                        echo "${i}" >> ${LOCATION}
                fi
  done
fi
done
fi
curl -O -L http://freelist.virussign.com/freelist/%23ZIP%20Password%20[virussign].txt > ${SAVE_FILES}/'#ZIP Password [virussign].txt'

rm -rf ${DOWNLOAD}
chown -R nginx: ${SAVE_FILES}