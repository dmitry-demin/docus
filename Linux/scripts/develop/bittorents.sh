#!/bin/bash


dst="/home/demin/torrents/files/"
trackerlist="http://192.168.0.58:8082/announce/"
#comment="TEst"
echo Введите Коментарий к торрент-файлу:
read A
echo $A
echo Введите Название торрент-файла:
read B
echo $B

for i in "${@}"
do
#  tname="$(echo ${i} | sed 's/\/$//g').torrent"
   tname="/home/demin/torrents/torrents/$B.torrent"
  mktorrent -a ${trackerlist} -o "${tname}" -c "$A" -v -p "${dst}"
#"${comment}" -v -p "${dst}"
done

#/usr/bin/mysql -e "SHOW TABLES LIKE '%HASH%'" -uroot -pNCCmAXpW6tVeKjfkGIvysfERL7rswWAZ


#mv /home/demin/torrents/files/*.torrent /home/demin/torrents/torrents/
#mv /home/demin/torrents/files/* /home/demin/torrents/distrib/

#sudo rm -rf /home/demin/torrents/files/*

#MAILTO=i.kostin@netville.ru
