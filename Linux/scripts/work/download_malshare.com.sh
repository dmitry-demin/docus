#!/bin/bash

SITE="http://malshare.com/daily/"
DOWNLOAD="/var/www/.download_files_malshare.com"
LOCATION="/etc/default/.download_files_malshare.com"
SAVE_FILES="/var/www/malshare.avsw.ru/files/"
> ${DOWNLOAD}
curl -l http://malshare.com/daily/ | egrep -o '[0-9]{4}-[0-9]{2}-[0-9]{2}\/|>malshare.current.[a-z0-9.*].+.txt|archive' | tee ${DOWNLOAD} 
sed -e 's/\">/ /g' ${DOWNLOAD} | sort | uniq >> /var/www/.download_files_malshare.com2
DOWNLOAD="/var/www/.download_files_malshare.com2"

for a in `cat ${DOWNLOAD}`
        do
CHECK_PID=`ps aux | grep "download_malshare.com.sh" | grep -v grep | wc -l`

if [ ${CHECK_PID} -le 2 ]
  then
  find ${SAVE_FILES} -empty -exec rm -rf {} \;

                if [ ${a} = `echo ${a} | egrep -o '[0-9]{4}-[0-9]{2}-[0-9]{2}\/'` ]
                then
                        for b in `curl -l ${SITE}${a} 2>&1 | egrep -o '>m.*.'txt | sed -e 's/>//g'`
                          do
                          if [ ! -d ${a} ]; then
                          mkdir -p ${SAVE_FILES}${a}
                                if [ ! -f ${SAVE_FILES}${a}${b} ]; then
                                curl -L ${SITE}${a}${b} > ${SAVE_FILES}${a}${b}
                                fi
                          fi
                        done
                else
                        echo @{a} | egrep 'archive'
                        if [ $? -eq 0 ]
                        then
                          if [ ! -d ${SITE}${a} ]
                          then
                            mkdir -p ${SAVE_FILES}${a}
                            curl -O ${SITE}${a}/April-Oct.tar.gz  
                            mv April-Oct.tar.gz ${SAVE_FILES}${a}/April-Oct.tar.gz
                          fi
                            else
                          if [ -f ${SAVE_FILES}${a}/April-Oct.tar.gz ]
                           then
                            curl -O ${SITE}${a}/April-Oct.tar.gz
                            mv April-Oct.tar.gz ${SAVE_FILES}${a}/April-Oct.tar.gz
                           fi
                         fi
                        echo @{a} | egrep -o 'malshare.current.txt'
                        if [ $? -eq 0 ]
                          then
                           curl -l ${SITE}${a} > ${SAVE_FILES}${a}
                         fi
                        echo @{a} | egrep -o 'malshare.current.sha1.txt'
                        if [ $? -eq 0 ]
                          then
                           curl -l ${SITE}${a} > ${SAVE_FILES}${a}
                         fi
                        echo @{a} | egrep -o 'malshare.current.all.txt'
                        if [ $? -eq 0 ]
                          then
                           curl -l ${SITE}${a} > ${SAVE_FILES}${a}
                         fi
                fi
done
fi
rm -rf ${DOWNLOAD}
chown -R nginx: ${SAVE_FILES}