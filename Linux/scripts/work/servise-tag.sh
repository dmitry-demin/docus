#!/bin/bash
sudo /bin/uname -a

sudo cat /etc/redhat-release

#echo "-------------------------------- Onli Fedora5 Core and RHEL 5"
#sudo /usr/sbin/dmidecode -s system-product-name
#sudo /usr/sbin/dmidecode -s system-serial-number

sudo /usr/sbin/dmidecode | grep "Product Name" | sed '1!d'
sudo /usr/sbin/dmidecode | grep "Serial Number"| sed '1!d'

