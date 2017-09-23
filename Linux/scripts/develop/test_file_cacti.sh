#!/bin/bash -x

files="cacti/0.8.7i"
if [ -d $files]
    then
        sed /\$files/d /tmp/webapp_cacti-0.8.7i
    else
        sed /$files/d /tmp/webapp_cacti-0.8.7i
    fi
exit
