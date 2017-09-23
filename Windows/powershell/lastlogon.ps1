import-module activedirectory 
cls
$domain = "lab.gemotest.ru" 
"Опрос домена " + $domain 
$samaccountname = Read-Host 'Доменная учетка (SamAccountName)?' 
"Processing the checks ..." 
$myForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest() 
$domaincontrollers = $myforest.Sites | % { $_.Servers } | Select Name 
$RealUserLastLogon = $null 
$LastusedDC = $null 
$domainsuffix = "*."+$domain 
foreach ($DomainController in $DomainControllers)  
{ 
    if ($DomainController.Name -like $domainsuffix ) 
    { 
        $UserLastlogon = Get-ADUser -Identity $samaccountname -Properties LastLogon -Server $DomainController.Name 
        if ($RealUserLastLogon -le [DateTime]::FromFileTime($UserLastlogon.LastLogon)) 
        { 
            $RealUserLastLogon = [DateTime]::FromFileTime($UserLastlogon.LastLogon) 
            $LastusedDC =  $DomainController.Name 
        } 
    } 
} 
"Последний вход был: " + $RealUserLastLogon + "" 
"С домена: " + $LastusedDC + "" 
#$mesage = "............." 
#$exit = Read-Host $mesage

Get-ADUser -Identity $samaccountname #| select name
echo "Почта:"
Get-Mailbox -Identity $samaccountname@gemotest.ru | select EmailAddresses
echo "Входит в группы:"
Get-ADPrincipalGroupMembership $samaccountname | select name | FT -AutoSize
