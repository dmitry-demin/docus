#!/bin/bash



_join="feodotracker ransomwaretracker ransomwaretracker2 ransomwaretracker3 zeustracker"
_sjoin="malwarepatrol quttera malwaredomainlist malwaredomains malwareblacklist malshare gatech"
_domain="avsw.ru"
_location="/etc/default/bases/BlockList"
_wlocation="/var/www"
_cfile="`date +%F_%H_%M`.csv"

cd ${_location}
python ${_location}/StartParse.py
python ${_location}/StartUpdate.py
#python ${_location}/RestAPI.py

for i in ${_join}
 do
   if [ -f ${_location}/${i}/`date +%F`*.csv ]
   then
        _filter=`ls -1 ${_wlocation}/abuse.${_domain}/ | egrep "^[0-9]{4}\-[0-9_-].+\.csv"`
        if [ `echo ${_filter} | wc -l` -eq 1 ]
        then
           rm -f ${_wlocation}/abuse.${_domain}/${_filter}
        fi
        for a in ${_join}
                 do
                    cat ${_location}/${a}/[0-9_-]*.csv >> ${_wlocation}/abuse.${_domain}/${_cfile}
                    chown nginx: ${_wlocation}/abuse.${_domain}/`date +%F`*.csv
                 done 
        break
   fi
done




for i in ${_sjoin}
 do
      find ${_wlocation}/${i}.${_domain}/ -regextype posix-extended -regex \/.+[0-9]\{4\}.+[0-9_-].+\.csv -exec rm -f {} \;
        if [ ${i} = "malwarepatrol" ]
        then
        cat ${_location}/${i}/[0-9_-]*.csv > ${_wlocation}/${i}.${_domain}/${_cfile}
        chown nginx: ${_wlocation}/${i}.${_domain}/${_cfile}
        elif [ ${i} = "quttera" ]
        then
        cat ${_location}/${i}/[0-9_-]*.csv > ${_wlocation}/${i}.${_domain}/${_cfile}
        chown nginx: ${_wlocation}/${i}.${_domain}/${_cfile}
        elif [ ${i} = "malwaredomainlist" ]
        then
        cat ${_location}/${i}/[0-9_-]*.csv > ${_wlocation}/${i}.${_domain}/${_cfile}
        chown nginx: ${_wlocation}/${i}.${_domain}/${_cfile}
        elif [ ${i} = "malwareblacklist" ]
        then
        cat ${_location}/${i}/[0-9_-]*.csv > ${_wlocation}/${i}.${_domain}/${_cfile}
        chown nginx: ${_wlocation}/${i}.${_domain}/${_cfile}
        elif [ ${i} = "malwaredomains" ]
        then
        cat ${_location}/mirrorcedia/[0-9_-]*.csv > ${_wlocation}/${i}.${_domain}/${_cfile}
        chown nginx: ${_wlocation}/${i}.${_domain}/${_cfile}
        elif [ ${i} = "malshare" ]
        then
        cat ${_location}/malsharecom/[0-9_-]*.csv > ${_wlocation}/${i}.${_domain}/${_cfile}
        chown nginx: ${_wlocation}/${i}.${_domain}/${_cfile}
        elif [ ${i} = "gatech" ]
        then
        cat ${_location}/panda_gtisc/[0-9_-]*.csv > ${_wlocation}/${i}.${_domain}/${_cfile}
        chown nginx: ${_wlocation}/${i}.${_domain}/${_cfile}
        fi
done
