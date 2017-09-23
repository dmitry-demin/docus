#!/bin/bash

#sudo ls -l /usr/local/utils/bin/mysqlbackup.sh

#sudo sed -i "s/kill $(cat $system_stunnel_pid)/#kill $(cat $system_stunnel_pid)/" /usr/local/utils/bin/mysqlbackup.sh
#sudo sed -i "s/sleep 2/#slep 2/" /usr/local/utils/bin/mysqlbackup.sh
#sudo sed -i "s/$system_stunnel/#$system_stunnel/" /usr/local/utils/bin/mysqlbackup.sh


#sed -i /usr/local/stunnel-4.44/bin/stunnel /etc/stunnel/stunnel.conf
#: ${system_stunnel="/usr/sbin/stunnel"
sudo sed -i 's/\/usr\/sbin\/stunnel/\/usr\/local\/stunnel-4.44\/bin\/stunnel \/etc\/stunnel\/stunnel.conf/g' /usr/local/utils/bin/mysqlbackup.sh
#sed -i 's/^kill \$(cat \$system_stunnel_pid)/#kill $(cat $system_stunnel_pid)/g' /home/demin/scripts/bash/work/test_sed
#sed -i 's/^sleep 2/#sleep 2/g' /home/demin/scripts/bash/work/test_sed
#sed -i 's/^\$system_stunnel/#$system_stunnel/g' /home/demin/scripts/bash/work/test_sed
