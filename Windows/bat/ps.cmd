SETCONSOLE /hide
PowerShell -Command "Set-ExecutionPolicy Unrestricted" >> "%TEMP%\Startup.log" 2>&1
PowerShell -windowstyle hidden %Name_Script%.ps1
