#!/bin/bash -x

dirdist="/usr/share/webapps/cacti/0.8.7i/htdocs"
dirinst="/var/www/cacti.test.dm/htdocs/cacti"

dist_txt="/tmp/dist.txt"
inst_txt="/tmp/inst.txt"
dist1_txt="/tmp/dist1.txt"
inst1_txt="/tmp/inst1.txt"
temp_txt="/tmp/end.txt"
temp1_txt="/tmp/end1.txt"
check_sort="grep -v -T -f $dist_txt"
check1_sort="grep -v -T -f $dist1_txt"

#        echo "========================================REMOVE OLD FILES======================================="

sudo rm -f $dist_txt $inst_txt $temp_txt $dist1_txt $inst1_txt $temp1_txt

#        echo "========================================CREATE  IS  FILES======================================="

#sudo find $dirdist -type f -exec bash -c 'echo "$(md5sum $1 | cut -f1 -d " " | sort -h) $(stat -c "%a %g %u" $1) $1"' _ {} \; > $dist_txt
#sudo find $dirinst -type f -exec bash -c 'echo "$(md5sum $1 | cut -f1 -d " " | sort -h) $(stat -c "%a %g %u" $1) $1"' _ {} \; > $inst_txt

sudo find $dirdist -type f -exec bash -c 'echo "$(md5sum $1 | cut -f1 -d " " ) $1"' _ {} \; > $dist1_txt
sudo find $dirinst -type f -exec bash -c 'echo "$(md5sum $1 | cut -f1 -d " " ) $1"' _ {} \; > $inst1_txt

sudo find $dirdist -type f -exec bash -c 'echo "$(stat -c "%a %g %u" $1 | cut -f1,2,3 -d " " ) $1"' _ {} \; > $dist_txt
sudo find $dirinst -type f -exec bash -c 'echo "$(stat -c "%a %g %u" $1 | cut -f1,2,3 -d " " ) $1"' _ {} \; > $inst_txt


sudo sed -i 's/\/usr\/share\/webapps\/cacti\/0.8.7i\/htdocs//g' $dist_txt
sudo sed -i 's/\/var\/www\/cacti.test.dm\/htdocs\/cacti//g' $inst_txt

sudo sed -i 's/\/usr\/share\/webapps\/cacti\/0.8.7i\/htdocs//g' $dist1_txt
sudo sed -i 's/\/var\/www\/cacti.test.dm\/htdocs\/cacti//g' $inst1_txt

#sudo sort -n $dist1_txt $inst1_txt
##sudo comm --output-delimiter=3 -12 $dist_txt $inst_txt







    #if [ "$dist_txt" == "$inst_txt" ]

    #then
    #    sudo echo "Установленные права на cacti не отличается от defaul webapp"$'\n' > $temp_txt
    #else
    #    sudo echo "Установленные права на cacti отличается от default webapp"$'\n' > $temp_txt
    #fi

    $check_sort $inst_txt >> $temp_txt


#for i in $inst1_txt

#do

    #if [ "$dist1_txt" == "$inst1_txt" ]

    #then
    #    sudo echo "Установленная сумма md5 не отличается от defaul webapp"$'\n' > $temp1_txt
    #else
    #    sudo echo "Установленная сумма md5 отличается от default webapp"$'\n' > $temp1_txt
    #fi

    $check1_sort $inst1_txt >> $temp1_txt

#done


   if [ awk '{ print $4 }' $temp1_txt == awk '{ print $2 }'$temp_txt ]
    then
        cat -A $temp1_txt $temp_txt
        else
        sudo sort -d $temp1_txt $temp_txt | cat -A
    fi



#sort -t "/" -d $temp_txt > /tmp/test
#sort -t "/" -k3 -d $temp1_txt > /tmp/test1



#paste -d " " $temp_txt $temp1_txt
#diff -y /tmp/test /tmp/test1




