#!/bin/bash



varm="--exclude=\"/dev/root/asd/\""



while getopts ":e:s:m:" Option

do

  case $Option

  in

    m ) m="--exclude=\"$OPTARG\""; varm="$varm $m";;

    s ) echo "Ключ s. Параметры ключа - $OPTARG";;

    e ) echo "Ключ e. Параметры ключа - $OPTARG";;

    * ) echo "Левый ключ. Иди нахуй.";;

  esac

done

echo $varm

