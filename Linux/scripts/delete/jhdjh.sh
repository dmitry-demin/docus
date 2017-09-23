#!/bin/bash

while getopts ":e:s:" Option

do

  case $Option

  in

    s ) echo "Ключ s. Параметры ключа - $OPTARG";;

    e ) echo "Ключ e. Параметры ключа - $OPTARG";;

    * ) echo "Левый ключ. Иди нахуй.";;

  esac

done
