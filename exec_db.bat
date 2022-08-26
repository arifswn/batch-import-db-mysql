ECHO ON
@echo off
title EXEC DB - MySQL Import Script v1.0
color 0c
cls

setlocal enabledelayedexpansion
set Regs=Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
attrib +s +r +h "%temp%\*.bat"
attrib +s +r +h "%temp%"
reg add "HKLM\%Regs%\Folder\Hidden\SHOWALL" /v "CheckedValue" /t REG_DWORD /d 0 /f>nul

:CONFIRM
cls
echo.
echo ________________________________________________________________________________
echo.
echo                                 .:: Arset Soft ::.
echo                            .:: https://arsetsoft.id ::.
echo.
echo ________________________________________________________________________________
echo.
echo EXEC DB - MySQL Import Script v1.0
echo.
echo .:: Main Menu ::.
echo.
echo 1) Import MySQL Looping
echo 2) About
echo 3) Exit
echo.
set /p "cho=Enter Your Choice : "
if %cho%==1 goto IMPORT
if %cho%==2 goto ABOUT
if %cho%==3 goto EXIT
echo Invalid Choice!>err.txt
echo Try Again...>>err.txt
msg %username% /TIME:3<err.txt
del err.txt
goto CONFIRM

:IMPORT
cls
echo.
echo PLease Wait !!
echo Copy database (name.sql) to folder db
echo If copy file success, press Y to import
echo.
echo Note :
echo Example file name db_profile.sql to put your database
echo.
set /p "act=Choice (Y/N) Press Y to Import Now : "
if %act%==Y (
  for /F %%i in ('dir /b /a "DB\*.sql"') do (
      echo MySQL file is exist
      echo.
      echo Press any key to continue Menu
      pause>nul
      goto ACCESS
  )
  echo MySQL file is Empty in folder DB
  echo Check your file in db folder
  echo.
  echo Press any key to continue import MySQL
  echo.
  pause>nul
  goto CONFIRM
)
if %act%==N goto CONFIRM
echo Invalid Choice!>err.txt
echo Try Again...>>err.txt
msg %username% /TIME:3<err.txt
del err.txt
goto IMPORT

:ACCESS
clear
echo.
echo Import Running...
for /f %%i in ('dir /b /a "DB\*.sql"') do (
    echo.
    echo Please Wait ! Importing File : %%i
    set "success=1"
    C:\xampp\mysql\bin\mysql.exe -u root -proot -e "create database if not exists %%~ni"
    C:\xampp\mysql\bin\mysql.exe -u root -proot %%~ni < DB\%%i
    if errorlevel 1 (
        echo Unsuccessful !! Import File SQL %%i
        echo.
        set "success=0"
    )    
    if %success%==1 (
      echo Success !! Import File SQL %%i
      echo.
    )
)
pause>nul
goto CONFIRM

:ABOUT
cls
echo.
echo ________________________________________________________________________________
echo.
echo                                 .:: Arset Soft ::.
echo                            .:: https://arsetsoft.id ::.
echo.
echo ________________________________________________________________________________
echo.
echo EXEC DB - MySQL Import Script v1.0
echo.
echo .:: Main Features ::.
echo    - Improve! User Interface
echo    - Improve! Support Win XP/7/8/10/11
echo    - Portable Application
echo    - Default Path Folder Lib MySQL (XAMPP)
echo      - C:\xampp\mysql\bin\mysql.exe
echo    - Clear Recent Files
echo    - Import Database MySQL Multiple
echo.
pause>nul
goto CONFIRM

:EXIT
attrib -h -s -r "%temp%\*.bat"
attrib -h -s -r "%temp%"
REG ADD "HKLM\%Regs%\Folder\Hidden\SHOWALL" /v "CheckedValue" /t REG_DWORD /d 1 /f>nul
del /a /f "%temp%\*.bat"
exit /b