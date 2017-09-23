#!/bin/bash
for a in "lex" "mike" "sid" "igor.fomin" "bovt"
	do
	echo "User is $a"
	echo -e "dnjhybr5c\n" | /usr/bin/sudo -S chage --list $a 2> /dev/null | egrep 'Последний|Last'
done
