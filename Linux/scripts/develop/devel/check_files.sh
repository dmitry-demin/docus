#!/bin/bash

#---------------------------------------------------------------------------------------------
#
#
#           File: check_files.sh
#
#
#          Usage: check_files.sh
#
#
#    Description: Script to check for changes in file directories and the files themselves.
#
#
#
#
#
#        Options: see function `usage`
#
#           Bugs: ---
#           Note: ---
#         Author: Demin Dmitry
#        Company: Netville
#
#        Version: 1.0
#        Created: 12/07/2013 - 12/07/2013
#
#
#
#---------------------------------------------------------------------------------------------

work_dir=( "/tmp/files/1 2"
"/tmp/files/2"
"/tmp/files/1" )

user_group="k.volodin@netville.ru
dpanov@netville.ru
sirocco@netville.ru
demin@netville.ru
"


#-----------------------
# variables
#-----------------------




for i in "${work_dir[@]}"
do

  find "$i" -mmin -5 | egrep '.*' > /dev/null 2>&1 && echo "$(hostname -f) Change files is ${i}" | sendmail $user_group && continue

done



#------------------------------------------------
# Latest cange                                  |
#------------------------------------------------
#                             |                 |
# Change directory            |  15 Jul 2013    |
#-----------------------------------------------|
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#                             |                 |
#------------------------------------------------
