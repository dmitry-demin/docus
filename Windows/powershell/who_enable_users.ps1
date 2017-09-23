#Get-ADuser -Identity dmitry.demin -Properties * | Select name,samaccountname

Get-ADUser -filter *|where {$_.enabled -eq $TRUE } | Format-Table name,samaccountname -AutoSize > C:\Users\dd_odmin\Desktop\users.txt