#Get-ADComputer -Filter * -Property * | Format-Table Name,OperatingSystem -Wrap –Auto

Get-ADComputer -Filter {OperatingSystem -NotLike "*server*"} -Property * | Format-Table Name -Wrap –Auto > C:\Users\dd_odmin\Desktop\windows7.txt
