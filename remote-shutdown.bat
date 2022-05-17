@echo off
:: Remote Shutdown 1.0

:: Michael Martins - 2022 
:: ---------  Changelog  ---------
:: -
::  13/05/2022 - Inicio / Criação

echo ----- Iniciado ---- %date% - %time:~0,8% >>log.txt
echo - >>log.txt

setlocal enabledelayedexpansion
for /F %%i in (IP_LIST.txt) do (
	
	:: Verify if the Station it is online
	ping -n 1 %%i | find "TTL=128" >nul
	IF !ERRORLEVEL! == 1 (
	echo Address %%i - Offline!
	echo Micro %%i Offline>> log.txt
	) else (
		echo Address %%i - Online!
		echo Micro %%i Online>> log.txt

		:: Verify if the computer allow remote access
		echo Address %%i - Trying access ...
		if not exist "\\%%i\c\windows\System32" ( 
			echo Address %%i - Online, but, no access.
			echo Micro %%i sem acesso>> log.txt
			) else ( 

			:: SHUTDOWN !
           		 psexec.exe \\%%i -s -u gti -p 6feira*13 shutdown -s -t 00 /f
			echo Micro %%i Desligado>> log.txt)))
echo - - - - - - Fim - - - - - ->> log.txt