#!/bin/bash


_config_file="conf.ini"

OLDIFS=$IFS
END=END

for a in $( grep "^\;" $_config_file ) ##&& grep '^\[' $_config_file )
do
  if [ "${a:0:1}" == ";" ]
  then
     echo $a
#    section="$a\;\//;"
#    section=${section/]/\\]}
#    IFS=$'\n'
#      for b in $( sed -n "/$section/"',$p' $config_file | grep -v $section )
#      do

        echo $b
#        param=$b
#        eval $param > /dev/null 2>&1
# done







#    else
#      exit
    fi
done


