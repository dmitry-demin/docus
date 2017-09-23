#Get-ADUser -Filter {Enabled -eq $false} -Properties sAMAccountName, Name | Select sAMAccountName, Name | Export-csv -path C:\Users\dd_odmin\Documents\ADUsers_disable-16-11.2016.csv -Encoding utf8 -NoTypeInformation

Get-ADUser -Filter {Enabled -eq $false} -properties * | Select Name,SamAccountName > C:\Users\dd_odmin\Documents\ad_users_disable-19.12.txt