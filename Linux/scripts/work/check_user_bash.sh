#!/bin/bash

host=$( hostname )
sudo -u root bash -c "echo $host"

sudo /usr/sbin/userdel wiz
sudo /usr/sbin/userdel bivan
sudo /usr/sbin/userdel devon
sudo /usr/sbin/userdel om
sudo /usr/sbin/userdel templer
sudo /usr/sbin/userdel msr
sudo /usr/sbin/usermod -s /sbin/nologin mysql
sudo sed -i "s/netdump/#netdump/" /etc/passwd
sudo /usr/sbin/groupdel wiz
sudo /usr/sbin/groupdel bivan
sudo /usr/sbin/groupdel devon
sudo /usr/sbin/groupdel om
sudo /usr/sbin/groupdel templer
sudo /usr/sbin/groupdel msr

sudo sed -i '/#om/d' /etc/passwd
sudo sed -i '/#wiz/d' /etc/passwd
sudo sed -i '/#bivan/d' /etc/passwd
sudo sed -i '/#devon/d' /etc/passwd
sudo sed -i '/#templer/d' /etc/passwd
sudo sed -i '/#msr/d' /etc/passwd

sudo sed -i '/#om/d' /etc/group
sudo sed -i '/#wiz/d' /etc/group
sudo sed -i '/#bivan/d' /etc/group
sudo sed -i '/#devon/d' /etc/group
sudo sed -i '/#templer/d' /etc/group
sudo sed -i '/#msr/d' /etc/group

sudo cat /etc/group | egrep 'wiz|bivan|devon|om|templer'

sudo rm -rf /home/{wiz,bivan,devon,om,templer}

echo ============ restart mysql ============
sudo /etc/init.d/mysql restart

echo ============ show pass ================
sudo cat /etc/passwd | grep bash

echo ============ show home ================
sudo ls -l /home

echo ============= show cron ===============
sudo ls -la /var/spool/cron
