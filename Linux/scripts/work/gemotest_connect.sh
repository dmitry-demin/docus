#!/bin/bash

if [ "$1" == '' ]
then
  echo "Parametres not found! Exit!"
  exit
elif [ "$1" != 'full' ] && [ "$1" != 'test' ] && [ "$1" != 'mysqlnonwork'] && [ "$1" != 'mysqlwork']
then
  echo "Parametres not found! Exit!"
  exit
fi


server_list_full="
www.gemotest.ru
144.76.234.116
176.9.146.157
182.168.8.5
185.59.101.29
192.168.10.2
192.168.108.11
192.168.108.12
192.168.108.123
192.168.108.18
192.168.108.199
192.168.108.22
192.168.108.26
192.168.108.33
192.168.108.35
192.168.108.37
192.168.108.47
192.168.108.5
192.168.108.60
192.168.108.61
192.168.108.62
192.168.108.7
192.168.108.87
192.168.108.88
192.168.108.95
192.168.109.168
192.168.109.20
192.168.109.63
192.168.110.137
192.168.110.17
192.168.110.53
192.168.110.62
192.168.156.2
192.168.156.22
192.168.20.13
192.168.20.14
192.168.8.7
"
server_list_test="
www.gemotest.ru
144.76.234.116
176.9.146.157
182.168.8.5
"

eval server_list='$server_list'_$1

for i in $server_list
do
  echo "===================== START $i ========================"
  sshpass -p "dnjhybr5c" scp -o StrictHostKeyChecking=no usechek.sh ${i}:
  sshpass -p "dnjhybr5c" ssh -A -o StrictHostKeyChecking=no $i './usechek.sh; rm -f usechek.sh'
  echo "===================== END $i =========================="
done
