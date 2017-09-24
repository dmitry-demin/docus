#!/bin/bash
LANG=C
# my @args = ('/usr/local/bin/av-scan', $token, $sha1, $sha256, $md5, $name);
eset_scan=/opt/eset/esets/sbin/esets_scan
#if [ false ]; then
#echo $0 \
#       d12c57d4-c51f-49b4-9d05-db62a19a2f8c \
#       DA39A3EE5E6B4B0D3255BFEF95601890AFD80709 \
#       9915f1e1d1ae6558fd5886832288f3cb6200db441bd9ba6d3ebfbb3a03c62b2a \
#       A9297219AE544C515EC5AB4645DB7E56 \
#       Pony.exe
#fi

#verdict=1
#result='N/A'
#name="${5}"

pwd=$(pwd)
tmp=$(mktemp -d) && report=$(mktemp) && {
        cd $tmp
        echo $tmp
        ext=$(echo $4 | cut -d. -f2)
        if [ -n "${ext}" ]; then
                ext=".${ext}"
        fi
        if [ -z "${name}" ]; then
                name="${3}"
        fi
        wget -q "ftp://vlir:vlir@192.168.0.52/${4}" -O "${tmp}/${name}" 
        if [ -f ${tmp}/${name} ]; then
                /opt/eset/esets/sbin/esets_scan * > ${report}
                result=$(cat ${report})
                verdict=1
                result1="Non Infected"
                detail_report=$( egrep ^name ${report} )
                _type=$( egrep -o 'threat=.+' ${report} | awk -F= {'print$2'} | sed -e 's/"//g' -e 's/, action//g' )

                suspicious=$( egrep 'threat.+'.+ ${report} | egrep 'adware|spyware|riskware' )
                if [ "$?" -eq 0 ]; then
                        verdict=2
                        result1="\"$(echo ${_type})\""
                fi
                infected=$( egrep 'threat.+'.+ ${report} | grep trojan )
                if [ "$?" -eq 0 ]; then
                        verdict=3
                        result1="\"$(echo ${_type})\""
                fi

                #echo $verdict
                #exit 0
        fi
        cd "$pwd"
}

curl -s -H "X-Auth-Token: $1" -X POST http://athena.local/api/v1/files/$2/av \
        -F verdict=$verdict \
        -F vendor=ESET \
        -F model="$( cat ${report} |grep ESET | awk -F\, {'print$1'} )" \
        -F version="$( cat ${report} | grep -v ESET | grep scanner | awk -F\, {'print$2'} | sed -e 's/ buil/buil/g' )" \
        -F db_version="$( cat ${report} | grep -v ESET | grep scanner | awk -F\, {'print$3'} | sed -e 's/ //g' )" \
        -F result="${result1}" \
        -F type="${_type}" \
        -F name="${name}" \
        -F detaild="${detail_report}"

#rm -rf ${tmp}
#rm -rf ${report}
