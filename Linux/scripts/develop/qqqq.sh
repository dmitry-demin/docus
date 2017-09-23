#!/bin/bash

section1=`cat file.ini | grep "^\s*\[.*\]\s*$"
#| sed 's/\[//g' | sed 's/\]//g'`

function pursing ()

{
   local _filename=./file.ini
   local _key=$1
   if [ ! -r "$_filename" ]
   then
     exit 1;
   fi
#IFS='\n'

   exec < $_filename
   while read section; do

#   for i in $section; do
#       echo -e $section
#       IFS="\n"
         if [ $section = $section1 ]; then
            IFS='='
            while read key value; do
        #check section
            if [ `echo -n $key | grep "^\s*\[.*\]\s*$"` ]; then
            exit 2;
        fi
       #show key
            key=`echo -n "$key" | sed 's/^\s*//;s/\s*$//'`
            _key=`echo -n "$_key" | sed 's/^\s*//;s/\s*$//'`

        if [ $key = $_key ]; then
           echo $value
           exit 0;
        fi
      done
    fi
#done
done
}


blabla=`pursing $1`
#echo $i
echo -e $blabla
