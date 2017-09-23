$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://ex1/PowerShell/ -Authentication Kerberos -Credential $UserCredential
Import-PSSession $Session -AllowClobber


Get-Maildabase -Server ex1

#Работает
#Get-Mailbox -Identity dmitry.demin 

#не работаеь
#Get-MessageTrackingLog -Server ex1 -Start "10/10/2016 11:00:00" -End "11/11/2016 11:30:00" -Recipients dmitry.demin@gemotest.ru
