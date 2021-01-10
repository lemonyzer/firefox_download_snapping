@echo off

:loop

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo datestamp: "%datestamp%"
echo timestamp: "%timestamp%"
echo fullstamp: "%fullstamp%"
echo.

echo.
echo parameter: %1
echo.

set "sourceFile=%1"
echo zu kopierende datei: %~n1
echo.

if exist "%1" goto :loop_continue
goto :exit_file_not_existing

:loop_continue
set "newFilename=%~n1-%fullstamp%"
echo kopie: %newFilename%

set "newFile=%~dp1%newFilename%%~x1"
echo speicherort: %newFile%

copy "%sourceFile%" "%newFile%"

rem ## 20 Minuten
rem ## set /a timeToWaitBetweenCallsInSeconds=20*60
rem ## 1 Sekunde
rem ## set /a timeToWaitBetweenCallsInSeconds=1

set /a timeToWaitBetweenCallsInSeconds=20*60
echo im Intervall: %timeToWaitBetweenCallsInSeconds% s
echo.

timeout /t %timeToWaitBetweenCallsInSeconds% /nobreak
cls
goto :loop


:exit_file_not_existing

echo.
echo %1 not existing, or no file specified, run the script with targetFile drag and dropped
echo.

:finish
pause
exit 