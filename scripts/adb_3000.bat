@echo off
set PORT=%1
if "%PORT%"=="" set PORT=3000

adb reverse --remove tcp:%PORT% 1>nul 2>nul
adb reverse tcp:%PORT% tcp:%PORT%
adb reverse --list
pause
