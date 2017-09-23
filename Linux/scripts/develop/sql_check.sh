#!/bin/bash


#Section arg check

_filename=./file.ini
#   local _key=$1

   if [ ! -r "$_filename" ]
   then
     exit 1;
   fi


