#!/bin/bash

ls -l /etc/my.cnf

echo '=============================================== cat /etc/my.cnf='

cat /etc/my.cnf





echo '=============================================== netstat and ps=='

sudo netstat -nlpa | grep 3306

sudo ps aux | grep mysql

