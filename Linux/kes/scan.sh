#!/bin/bash

# my @args = ('/usr/local/bin/av-scan', $token, $sha1, $sha256, $md5, $name);
kes=/opt/kaspersky/kes4lwks/bin/kes4lwks-control
#if [ false ]; then
#echo $0 \
#       d12c57d4-c51f-49b4-9d05-db62a19a2f8c \
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
        cd $tmp
        echo $tmp
        ext=$(echo ${5} | cut -d. -f2)
        if [ -n "${ext}" ]; then
                ext=".${ext}"
        fi
        if [ -z "${name}" ]; then
                name="${4}"
        fi
        wget -q "ftp://vlir:vlir@192.168.0.52/${5}" -O "${tmp}/${name}"
        if [ -f ${tmp}/${name} ]; then 
                /opt/kaspersky/kes4lwks/bin/kes4lwks-control --create-task ${name} --use-task-type ODS
                /opt/kaspersky/kes4lwks/bin/kes4lwks-control --set-settings ${name} --use-name ScanScope:AreaPath:Path=${tmp}
                /opt/kaspersky/kes4lwks/bin/kes4lwks-control --start-task ${name} --use-name
                /opt/kaspersky/kes4lwks/bin/kes4lwks-control -E --query "(TaskName==s'${name}' and EventType==s'ThreatDetected')" > 2&>1 > ${report}
                result=$(cat ${report})
                infected=$( egrep ^VerdictType ${report} | awk -F\= '{ print $2 }' | sort | uniq )
                verdict=1
                _result1="Non infected"
                _type=$( egrep ^VerdictType ${report} | awk -F\= '{ print $2 }' )
                _name=$( egrep ^ThreatName ${report} | awk -F\= '{ print $2 }' | sed -e 's/HEUR://g' )
                if [ ${infected} = '"Trojware"' ]; then
                        verdict=3
                        _result1="$_name"
                fi
                if [ ${infected} = '"Malware"' ]; then
                        verdict=3
                        _result1="$_name"
                fi        
                if [ ${infected} = '"Virware"' ]; then
                        verdict=3
                        _result1="$_name"
                fi
                if [ ${infected} = '"Adware"' ]; then
                        verdict=2
                        _result1="$_name"
                fi
                if [ ${infected} = '"Pornware"' ]; then
                        verdict=2
                        _result1="$_name"
                fi
                if [ ${infected} = '"Riskware"' ]; then
                        verdict=2
                        _result1="$_name"
                fi 

                # echo $verdict
                # exit 0
        fi
        cd "$pwd"
}
#echo curl -s -H "X-Auth-Token: $1" -X POST https://athena.avsw.ru/api/v1/files/$3/av \
#        -F verdict=$verdict \
#        -F vendor=$(/opt/kaspersky/kes4lwks/bin/kes4lwks-control  -L --get-installed-keys | egrep App | awk {'print$3'}) \
#        -F model=$(/opt/kaspersky/kes4lwks/bin/kes4lwks-control  -L --get-installed-keys | egrep App | awk {'print$3,$4,$5'}) \
#        -F version=$(rpm -qa | grep kes | sed -e 's/kes4lwks-//g' -e 's/.i386//g') \
#        -F db_version=1 \
#        -F result="${_result1}" \
#        -F type="${_type}" \
#        -F name="${_name}" \
#        -F details=\"`cat ${report}`\"


curl -s -H "X-Auth-Token: $1" -X POST http://athena.local/api/v1/files/$3/av \
        -F verdict=$verdict \
        -F vendor=$(/opt/kaspersky/kes4lwks/bin/kes4lwks-control  -L --get-installed-keys | egrep App | awk {'print$3'}) \
        -F model=$(/opt/kaspersky/kes4lwks/bin/kes4lwks-control  -L --get-installed-keys | egrep App | awk {'print$3,$4,$5'}) \
        -F version='8.0.1-50' \
        -F db_version="1" \
        -F result="$_result1" \
        -F type="${_type}" \
        -F name="${_name}" \
        -F details=\"`cat ${report}`\"


/opt/kaspersky/kes4lwks/bin/kes4lwks-control --delete-task ${name} --use-name
/opt/kaspersky/kes4lwks/bin/kes4lwks-control -E --remove "(TaskName==s'${name}')"


rm -rf /tmp/*
