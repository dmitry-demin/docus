#!/bin/bash

check_first_ps="ps aux | grep start_game.sh | grep -v grep |  wc -l"
check_second_ps="cat /etc/rc.local | grep start_game.sh | grep -v grep | wc -l"


if [ "check_first_ps" = "check_second_ps" ]; then
    echo "All GOOD !!!"
else
    echo "Warning need restart service !!!"
fi


