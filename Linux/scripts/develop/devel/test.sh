#!/bin/bash

todaydate=$(date "+%Y%m%d")
onedaydate=$(date "+%Y%m01")
config_file="$1"
OLDIFS=$IFS
END=END

if [ -f "$config_file" ]
 then
  for disable_section in $( grep '^\;' $config_file )
  do
        IFS=$'\n'
        echo $disable_section
        #for comment_section in $( sed -n "/$disable_section/"',$p' $config_file ) # | grep -v $disable_section )
        #do
            echo $comment_section
           #if [ ${comment_section} = ';' ]
           # then
           #     disable_param=\;${comment_section}
           #     eval disable_param > /dev/null 2>&1
           #     echo $disable_param
           #fi
  # done
  done

#  for i in $( grep '^\[' $config_file )
#  do
#    section=${i/[/\\[}
#    section=${section/]/\\]}
#       IFS=$'\n'
#    if [ "$section" != '\['$END'\]' ] && [ "$section" = "$section" ]
#    then
#       #echo ""$section" = "$section""
#       for b in $( sed -n "/$section/"',$p' $config_file ) # | grep -v $section )
#       do
#        if [ ${b:0:1} != '[' ]
#        then
#        if [ ${section_dis:0:1} != ${b:0:1} ]
#        then
#        continue 2;
#        fi
#        else
#            for c in $( sed -n "/$section/"',$p' $config_file | grep -v $section )
#            do
#                echo $c
#            done
#        fi
#       done
#     else
#        echo "$section != $section"
#     fi
#    done
else
    echo "file not found"
fi

