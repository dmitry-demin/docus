Add-Type -AssemblyName System.Windows.Forms
while ($true)
{
    Start-Sleep 2
    $_proc = "excel", "winword", "msaccess"
    foreach ( $_proc in $_proc )
    {
        $name=Get-Process | Select ProcessName
        if ( $name | ? { $_.ProcessName -eq $_proc } )
         {
        $getpid=(Get-Process -Name $_proc).Name
            if ( $getpid -eq "excel" )
            {
            $Pos = [System.Windows.Forms.Cursor]::Position
            $x = ($pos.X % 900) + 10
            $y = ($pos.Y % 900) + 20
            $Up = Start-Sleep 1.5
            [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            $x = ($pos.X % 900) + 20
            $y = ($pos.Y % 900) + 10
            [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
            $x = ($pos.X % 900) + 20
            $y = ($pos.Y % 900) + 10
            [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{ENTER}{ENTER}{END}{END}{END}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Get up Trinity. Just get up. Get up.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Wake up, Neo...{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Knock, knock, Neo.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("The Matrix has you...{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("You know that road. You know exactly where it ends. And I know that's not where you want to be…{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Neo, I'm not afraid anymore. The Oracle told me that I would fall in love, and that man, the man who I loved would be the one. And so you see, you can't be dead. You can't be, because I love you. You hear me? I love you… Now get up.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Have you ever stood and stared at it, marveled at it's beauty, it's genius? Billions of people just living out their lives, oblivious. Did you know that the first Matrix was designed to be a perfect human world. Where none suffered. Where everyone would be happy. It was a disaster. No one would accept the program. Entire crops were lost. Some believed that we lacked the programming language to describe your perfect world. But I believe that as a species, human beings define their reality through misery and suffering. The perfect world would dream that your primitive cerebrum kept trying to wake up from. Which is why the Matrix was redesigned to this, the peak of your civilization. I say your civilization because as soon as we started thinking for you it really became our civilization which is of course what this is all about. Evolution, Morpheus, evolution, like the dinosaur. Look out that window. You had your time. The future is our world, Morpheus. The future is our time.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("I'd like to share a revelation that I've had during my time here. It came to me when I tried to classify your species. I realized that you're not actually mammals. Every mammal on this planet instinctively develops a natural equilibrium with the surrounding environment but you humans do not. You move to an area and you multiply and multiply until every natural resource is consumed. The only way you can survive is to spread to another area. There is another organism on this planet that follows the same pattern. Do you know what it is? A virus. Human beings are a disease, a cancer of this planet. You are a plague, and we are the cure.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("No Lieutenant, your men are already dead.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Wake up, Neo...{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Wake up, Neo...{ENTER}")
            $Up 
            }
            if ( $getpid -eq "winword" )
            {
            $Pos = [System.Windows.Forms.Cursor]::Position
            $x = ($pos.X % 900) + 10
            $y = ($pos.Y % 900) + 20
            $Up = Start-Sleep 1.5
            [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            $x = ($pos.X % 900) + 20
            $y = ($pos.Y % 900) + 10
            [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
            $x = ($pos.X % 900) + 20
            $y = ($pos.Y % 900) + 10
            [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            $x = ($pos.X % 900) + 10
            $y = ($pos.Y % 900) + 20
            $Up = Start-Sleep 1.5
            [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
            $Up
            [System.Windows.Forms.SendKeys]::SendWait("{ENTER}{ENTER}{END}{END}{END}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Get up Trinity. Just get up. Get up.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Wake up, Neo...{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Knock, knock, Neo.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("The Matrix has you...{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("You know that road. You know exactly where it ends. And I know that's not where you want to be…{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Neo, I'm not afraid anymore. The Oracle told me that I would fall in love, and that man, the man who I loved would be the one. And so you see, you can't be dead. You can't be, because I love you. You hear me? I love you… Now get up.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Have you ever stood and stared at it, marveled at it's beauty, it's genius? Billions of people just living out their lives, oblivious. Did you know that the first Matrix was designed to be a perfect human world. Where none suffered. Where everyone would be happy. It was a disaster. No one would accept the program. Entire crops were lost. Some believed that we lacked the programming language to describe your perfect world. But I believe that as a species, human beings define their reality through misery and suffering. The perfect world would dream that your primitive cerebrum kept trying to wake up from. Which is why the Matrix was redesigned to this, the peak of your civilization. I say your civilization because as soon as we started thinking for you it really became our civilization which is of course what this is all about. Evolution, Morpheus, evolution, like the dinosaur. Look out that window. You had your time. The future is our world, Morpheus. The future is our time.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("I'd like to share a revelation that I've had during my time here. It came to me when I tried to classify your species. I realized that you're not actually mammals. Every mammal on this planet instinctively develops a natural equilibrium with the surrounding environment but you humans do not. You move to an area and you multiply and multiply until every natural resource is consumed. The only way you can survive is to spread to another area. There is another organism on this planet that follows the same pattern. Do you know what it is? A virus. Human beings are a disease, a cancer of this planet. You are a plague, and we are the cure.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("No Lieutenant, your men are already dead.{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Wake up, Neo...{ENTER}")
            $Up 
            [System.Windows.Forms.SendKeys]::SendWait("Wake up, Neo...{ENTER}")
            $Up 
              }
            if ( $getpid -eq "msaccess" )
            {
              $Pos = [System.Windows.Forms.Cursor]::Position
                $x = ($pos.X % 900) + 100
                $y = ($pos.Y % 900) + 60
                $Up = Start-Sleep 2
    
                    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
                    $Up 
            }
             
         }
                 
    }
}
