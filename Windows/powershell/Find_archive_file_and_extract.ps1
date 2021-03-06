$DIR = "C:\"
$formats = Get-ChildItem $DIR -Force | where {$_.BaseName -match "^[a-zA-Z0-9]{32}$"}

if (!(Test-Path $DIR))
    {
    echo "Notfing to do.... Exit"
    exit 
    }
foreach ( $i in $formats)
    {
           $DirFullName = $i.FullName
           $FullName = $i.BaseName
   
          if ([IO.PAth]::GetExtension($i.Name) -eq ".zip")
           
    {
          if (!(Test-Path -Path $DIR$FullName)) 
            {
            New-Item -ItemType Directory -Force -Path $Dir$FullName
            }
            $shell = New-Object -Com shell.application
            $zip = $shell.NameSpace($DirFullName)
            foreach ($item in $zip.items())
                {
                    $Shell.NameSpace("$DIR$FullName").copyhere($item)
                }
    }
        else
    {
         if (!(Test-Path -Path $DIR$FullName)) 
            {
            New-Item -ItemType Directory -Force -Path $Dir$FullName
            }
            &"c:\Program Files\7-Zip\7z.exe" "x" $DirFullName "-o$DIR$FullName"
    }
}

Clear-Host

Get-ChildItem -Path $DIR$FullName 
