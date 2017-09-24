#!/bin/bash
# my @args = ('/usr/local/bin/av-scan', $token, $sha1, $sha256, $md5, $name);
drweb=/usr/bin/drweb-ctl
#if [ false ]; then
#echo $0 \
#       DA39A3EE5E6B4B0D3255BFEF95601890AFD80709 \
#       9915f1e1d1ae6558fd5886832288f3cb6200db441bd9ba6d3ebfbb3a03c62b2a \
#       A9297219AE544C515EC5AB4645DB7E56 \
#       Pony.exe
#fi
verdict=1
result='N/A'
name="${5}"

pwd=$(pwd)
tmp=$(mktemp -d) && report=$(mktemp) && {
        cd ${tmp}
        echo ${tmp}
        ext=$(echo ${5} | cut -d. -f2)
        if [ -n "${ext}" ]; then
                ext=".${ext}"
        fi
        if [ -z "${name}" ]; then
                name="${4}"
        fi
        wget -q "ftp://vlir:vlir@192.168.0.52/${5}" -O "${tmp}/${name}" 
                if [ -f ${tmp}/${name} ]; then
                /usr/bin/drweb-ctl scan --Report DEBUG "${tmp}/${name}" > 2&>1 > ${report}
                echo "${tmp}/${name}"
                result=$(cat ${report})
                verdict=1
                result1="Non Infected"
                # try to check infected?
                infected=$( egrep -i virus ${report} )
                if [ "$?" -eq 0 ]; then
                        verdict=3
                        result1=`egrep -A2 virus ${report} | grep name | awk -F\: {'print$2'}`
                fi
                # downgrate verdict to adware
                infected=$( egrep -i Adware ${report} )
                if [ "$?" -eq 0 ]; then
                        verdict=2
                        result1=`egrep -A2 virus ${report} | grep name | awk -F\: {'print$2'}`
                fi

                _type=$( egrep 'type:' ${report} | awk -F\: '{print$2}' )
                _name=$( egrep 'name:' ${report} | awk -F\: '{print$2}' )
                detail_report=$( egrep -A8 report ${report} )
                #echo $verdict
                #exit 0

        fi
        cd "$pwd"
}
curl -s -H "X-Auth-Token: $1" -X POST http://athena.local/api/v1/files/$3/av \
        -F verdict=$verdict \
        -F vendor=Drweb \
        -F model=$(rpm -aq drweb-workstations | sed -e 's/linux.noarch//g' -e 's/drweb-//g') \
        -F version=$(drweb-ctl --version | awk {'print$2'}) \
        -F db_version=$(drweb-ctl baseinfo | grep Core | sed 's/Core engine: //g') \
        -F result="${result1}" \
        -F type="${_type}" \
        -F name="${_name}" \
        -F detaild="${report}"

rm -rf /tmp/*
