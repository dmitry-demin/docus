@echo "#########################"

@echo "# Continued loading... #"

@echo "#########################"

@reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters" /v "DomainCompatibilityMode" /t REG_DWORD /d "00000001" /f

@reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters" /v "DNSNameResolutionRequired" /t REG_DWORD /d "00000000" /f

@echo "#########################"

@echo "# Speed NET w7... #"

@reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "DeleteRoamingCache" /t REG_DWORD /d "00000001" /f

@reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "CompatibleRUPSecurity" /t REG_DWORD /d "00000001" /f

@reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "SlowLinkDetectEnabled" /t REG_DWORD /d "00000000" /f

@reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "WaitForNetwork" /t REG_DWORD /d "00000000" /f

@echo "#########################"

@echo "# Stop BRAIN nuts... #"

@echo "#########################"

@reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "00000000" /f

@echo "#########################"

@echo "# SpeedUP Windows #"

@echo "#########################"

@reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" -t REG_DWORD /d "00000009" /f
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" -t REG_DWORD /d "00000000" /f
@reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" -t REG_DWORD /d "64" /f
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" -t REG_DWORD /d "00000002" /f

@echo "#########################"

@echo "# I`m are evil :)) #"

@echo "#########################"

powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 50
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 25
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 0
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100
powercfg -setactive scheme_current
POWERCFG -Change -standby-timeout-ac 0
powercfg -h off

regedit /S speed.reg
regsvr32 actxprxy.dll