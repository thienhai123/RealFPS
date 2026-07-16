:DIAGNOSTICS

cls

call :PINK_LINE
call :PINK_CENTER "GAMING DIAGNOSTICS"
call :PINK_LINE

echo.


echo CPU:
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"


echo.

echo GPU:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"


echo.

echo Driver:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object DriverVersion"


echo.

echo Disk:
powershell -command "Get-PSDrive C | Select-Object Used,Free"


echo.

echo Network:
ping 8.8.8.8 -n 4


call :LOG "Diagnostics Completed"


pause

goto MENU_TOOLS











:REPORT

cls

call :PINK_LINE
call :PINK_CENTER "GENERATE REPORT"
call :PINK_LINE


echo Creating report...


echo ===================================== > RealFPS_Report.txt
echo RealFPS System Report >> RealFPS_Report.txt
echo ===================================== >> RealFPS_Report.txt


echo. >> RealFPS_Report.txt

echo Version: >> RealFPS_Report.txt
echo %VERSION% >> RealFPS_Report.txt


echo. >> RealFPS_Report.txt

echo CPU: >> RealFPS_Report.txt
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name" >> RealFPS_Report.txt


echo. >> RealFPS_Report.txt

echo GPU: >> RealFPS_Report.txt
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name" >> RealFPS_Report.txt


echo. >> RealFPS_Report.txt

echo RAM: >> RealFPS_Report.txt
powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB,2)" >> RealFPS_Report.txt


call :SUCCESS "Report Created"

goto MENU_INFO











:DEV_INFO

cls

call :PINK_LINE
call :PINK_CENTER "DEVELOPER INFO"
call :PINK_LINE

echo.


call :CENTER "Project: RealFPS"
call :CENTER "Version: %VERSION%"
call :CENTER "Build: %BUILD%"
call :CENTER "Developer: %DEVELOPER%"
call :CENTER "Language: Batch Script"


pause

goto MENU_INFO











:ENV_CHECK

cls

call :PINK_LINE
call :PINK_CENTER "ENVIRONMENT CHECK"
call :PINK_LINE

echo.


echo Checking Windows...
ver


echo.

echo Checking PowerShell...

powershell -command "Write-Host PowerShell OK"


echo.

echo Checking PowerCFG...

powercfg /getactivescheme >nul


timeout /t 2 >nul


exit /b











:: =============================
:: DISPLAY FUNCTIONS
:: =============================


:PINK_LINE

<nul set /p "=[95m==================================================[97m"
echo.

exit /b







:PINK_CENTER

setlocal EnableDelayedExpansion

set "text=%~1"

set /a width=50
set /a len=0


for /l %%A in (0,1,100) do (

if "!text:~%%A,1!"=="" (

set /a len=%%A
goto pink_count

)

)


:pink_count

set /a space=(width-len)/2


set "pad="

for /l %%A in (1,1,!space!) do (

set "pad=!pad! "

)


<nul set /p "=[95m!pad!!text![97m"
echo.


endlocal

exit /b







:CENTER

setlocal EnableDelayedExpansion

set "text=%~1"

set /a width=50
set /a len=0


for /l %%A in (0,1,100) do (

if "!text:~%%A,1!"=="" (

set /a len=%%A
goto center_count

)

)


:center_count

set /a space=(width-len)/2


set "pad="

for /l %%A in (1,1,!space!) do (

set "pad=!pad! "

)


echo !pad!!text!


endlocal

exit /b







:MENU_ITEM

<nul set /p "=[92m[[97m%~1[92m][97m %~2"
echo.

exit /b







:BACK_ITEM

<nul set /p "=[93m[[97m%~1[93m][97m %~2"
echo.

exit /b







:SUCCESS

echo.
<nul set /p "=[92m[SUCCESS][97m %~1"
echo.

call :LOG "SUCCESS - %~1"

pause

exit /b







:FAILED

echo.
<nul set /p "=[91m[FAILED][97m %~1"
echo.

call :LOG "FAILED - %~1"

pause

exit /b







:LOG

echo [%date% %time%] %~1 >> RealFPS_Log.txt

exit /b







:: =============================
:: STATUS CHECK
:: =============================


:CHECK_POWER

for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set power=%%a


if /i "%power%"=="381b4222-f694-41f0-9685-ff5bb260df2e" (
echo [BALANCED] Power Plan
) else if /i "%power%"=="8c5e7fda-e8bf-4a96-9a85-a6e23a8c83d5" (
echo [HIGH] Power Plan
) else if /i "%power%"=="e9a42b02-d5df-448d-aa00-03f14749eb61" (
echo [ULTIMATE] Power Plan
) else (
echo [CUSTOM] Power Plan
)

exit /b







:CHECK_GAME

for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled 2^>nul') do set gm=%%a


if "%gm%"=="0x1" (
echo [ON] Game Mode
) else (
echo [OFF] Game Mode
)

exit /b







:CHECK_DVR

for /f "tokens=3" %%a in ('reg query "HKCU\System\GameConfigStore" /v GameDVR_Enabled 2^>nul') do set dvr=%%a


if "%dvr%"=="0x1" (
echo [ON] Xbox DVR
) else (
echo [OFF] Xbox DVR
)

exit /b







:CHECK_HAGS

for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode 2^>nul') do set hags=%%a


if "%hags%"=="0x2" (
echo [ON] HAGS
) else (
echo [OFF] HAGS
)

exit /b
