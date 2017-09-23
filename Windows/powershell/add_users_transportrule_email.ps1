
$email = Get-Content C:\Users\dd_odmin\Desktop\email.txt
$alias = Get-Content C:\Users\dd_odmin\Desktop\alias.txt

New-TransportRule -Name scadmin2-1 -AddToRecipients $email -BlindCopyTo scadmin2@gemotest.ru
New-TransportRule -Name scadmin-1 -SentTo $email -BlindCopyTo scadmin2@gemotest.ru

