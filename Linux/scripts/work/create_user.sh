#!/bin/bash

name="demin"
home="/home/demin"
shell="/bin/bash"
uid="1001"
gid="1001"

##pass=`sudo cat /dev/urandom | tr -dc a-zA-Z0123456789 | head -c 20`
sudo /usr/sbin/groupadd -g$gid $name
sudo /usr/sbin/useradd -s$shell  -d$home -u$uid -g$gid -m $name

##echo "User $name success add with $pass"
