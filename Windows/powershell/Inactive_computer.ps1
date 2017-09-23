﻿# Gets time stamps for all computers in the domain that have NOT logged in since after specified date 
# Mod by Tilo 2013-08-27 
import-module activedirectory  
$domain = "lab.gemotest.ru"  
$DaysInactive = 45  
$time = (Get-Date).Adddays(-($DaysInactive)) 
  
# Get all AD computers with lastLogonTimestamp less than our time 
Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp | 
  
# Output hostname and lastLogonTimestamp into CSV 
select-object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | export-csv C:\Users\dd_odmin\Desktop\OLD_Computer45.csv -notypeinformation