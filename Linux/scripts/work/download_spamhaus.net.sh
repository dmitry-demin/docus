#!/bin/bash

SITE="na.dr.spamhaus.net/"
SAVE_FILES="/var/www/spamhaus.avsw.ru/files/"

spamh="rbldnsd security bots_b bots_c bots_f bots_r bots_s free tools datafeed_dom datafeed_ip datafeed measure res-sy"

for i in `echo $spamh`
        do 
        rsync -r -L -t --timeout=120 --bwlimit=64 rsync://na.dr.spamhaus.net/${i} ${SAVE_FILES}${i} 
done