#!/bin/bash                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                             
#SITE="http://panda.gtisc.gatech.edu/malrec/movies/ http://panda.gtisc.gatech.edu/malrec/pcap/ http://panda.gtisc.gatech.edu/malrec/vt/ http://giantpanda.gtisc.gatech.edu/malrec/movies/ http://giantpanda.gtisc.gatech.edu/malrec/pcap/ http://giantpanda.gtisc.gatech.edu/malrec/vt/"                                                                                                                                                                                                  
SITE="http://panda.gtisc.gatech.edu/malrec/ http://giantpanda.gtisc.gatech.edu/malrec/"                                                                                                                                                      
LINKS="movies pcap vt"
DOWNLOAD="/var/www/.download_files_gatech.avsw.ru"
LOCATION="/etc/default/.download_files_gatech.avsw.ru"
SAVE_FILES="/var/www/gatech.avsw.ru/files/"
CHECK_PID=`ps aux | grep "download_gatech.avsw.ru.sh" | grep -v grep | wc -l`

if [ ${CHECK_PID} -le 2 ]
  then
#find ${SAVE_FILES} -empty -exec rm -rf {} \;

#       curl -l http://panda.gtisc.gatech.edu/malrec// 2>&1 | egrep -o "[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+.mp4" | sort | uniq | tee -a ${DOWNLOAD}
#       curl -l ${a}${b}/ 2>&1 | egrep -o "[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+.pcap" | sort | uniq | tee -a ${DOWNLOAD}
#       curl -l ${a}${b}/ 2>&1 | egrep -o "[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+.json" | sort | uniq | tee -a ${DOWNLOAD}

rm -f /var/www/.download_files_gatech.avsw.ru.*.txt
for a in `echo ${SITE}`; do
if [ -f ${LOCATION} ]
then
 for b in ${LINKS}
 do
  if [ ${b} = 'movies' ]
  then
rm -f /var/www/.download_files_gatech.avsw.ru.mp4.txt
        if [ ! -f /var/www/.download_files_gatech.avsw.ru.mp4.txt ]
        then
        curl -l ${a}${b}/ 2>&1 | egrep -o "[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+.mp4" | sort | uniq | tee /var/www/.download_files_gatech.avsw.ru.mp4.txt
          for i in `cat /var/www/.download_files_gatech.avsw.ru.mp4.txt`
          do
            if [ ! -d ${SAVE_FILES}${b} ]
            then
                mkdir -p ${SAVE_FILES}${b}
                cd ${SAVE_FILES}${b}/
                curl -O -L ${a}${b}/${i}
                echo ${i} >> ${LOCATION}
            else
                if [ ! -f ${SAVE_FILES}${b}/${i} ]
                then
                  cd ${SAVE_FILES}${b}/
                  curl -O -L ${a}${b}/${i}
                  echo ${i} >> ${LOCATION}
                fi
            fi
          done
        fi
  elif [  ${b} = 'pcap' ]
  then
rm -f /var/www/.download_files_gatech.avsw.ru.pcap.txt
        if [ ! -f /var/www/.download_files_gatech.avsw.ru.pcap.txt ]
          then
            curl -l ${a}${b}/ 2>&1 | egrep -o "[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+.pcap" | sort | uniq | tee /var/www/.download_files_gatech.avsw.ru.pcap.txt
            for i in `cat /var/www/.download_files_gatech.avsw.ru.pcap.txt`
              do
                if [ ! -d ${SAVE_FILES}${b} ]
                then
                  mkdir -p ${SAVE_FILES}${b}  
                  cd ${SAVE_FILES}${b}
                  curl -O -L ${a}${b}/${i}
                  echo ${i} >> ${LOCATION}
                else
                  if [ ! -f ${SAVE_FILES}${b}/${i} ]
                   then
                     cd ${SAVE_FILES}${b}
                     curl -O -L ${a}${b}/${i}
                     echo ${i} >> ${LOCATION}
                  fi  
               fi
            done
        fi
  elif [ ${b} = 'vt' ]
  then
rm -f /var/www/.download_files_gatech.avsw.ru.json.txt
        if [ ! -f /var/www/.download_files_gatech.avsw.ru.json.txt ]
          then
            curl -l ${a}${b}/ 2>&1 | egrep -o "[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+-[[:alnum:]]+.json" | sort | uniq | tee /var/www/.download_files_gatech.avsw.ru.json.txt
          for i in `cat /var/www/.download_files_gatech.avsw.ru.json.txt`
            do
              if [ ! -d ${SAVE_FILES}${b} ]
              then
                mkdir -p ${SAVE_FILES}${b}
                cd ${SAVE_FILES}${b}
                curl -O -L ${a}${b}/${i}
                echo ${i} >> ${LOCATION}
              else
                if [ ! -f ${SAVE_FILES}${b}/${i} ]
                then
                   cd ${SAVE_FILES}${b}
                   curl -O -L ${a}${b}/${i}
                   echo ${i} >> ${LOCATION}
                fi
              fi
           done
         fi
  fi
 done
fi
done

else
echo "Process is Running"
ps aux | grep 'download_gatech.avsw.ru.sh'
fi

rm -f /var/www/.download_files_gatech.avsw.ru.*.txt
chown -R nginx: ${SAVE_FILES}