@echo off
title Spend Dat Shyt Backup Monitor

set DB_USER=root
set DB_NAME=qbox_e24256
set BACKUP_DIR=C:\Users\Administrator\Desktop\COC\resources\BACKUP\DatabaseBackups
set MYSQL_BIN=C:\Program Files\MariaDB 11.6\bin

if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:LOOP
cls
echo =====================================
echo Current Time: %date% %time%
echo Starting Backup...
echo =====================================

set FILE=%BACKUP_DIR%\%DB_NAME%_%DATE:~-4%%DATE:~4,2%%DATE:~7,2%_%TIME:~0,2%%TIME:~3,2%.sql
set FILE=%FILE: =0%

"%MYSQL_BIN%\mysqldump.exe" -u %DB_USER% %DB_NAME% > "%FILE%"

for %%A in ("%FILE%") do set SIZE=%%~zA

if %SIZE% LEQ 1000 (
    echo Backup FAILED or EMPTY FILE!
    echo Deleting empty file...
    del "%FILE%"
) else (
    echo Backup SUCCESS!
    echo File: %FILE%
    echo Size: %SIZE% bytes
)

echo.
echo Last backup: %date% %time%
echo Next backup in 6 hours...
timeout /t 21600

goto LOOP