@echo off
:: Remote Shutdown 1.0

:: Michael Martins - 2022 
:: ---------  Changelog  ---------
:: -
::  13/05/2022 - Inicio / Criação

setlocal enabledelayedexpansion
for /F %%i in (IP_LIST.txt) do (
	:: Verify if the Station it is online
	ping -n 1 %%i | find "TTL=128" >nul
	IF !ERRORLEVEL! == 1 (
	ECHO Address %%i - Offline!
	echo %%i >> offline.txt
	) else (
		ECHO Address %%i - Online!
		echo %%i >> online.txt

		:: Verify if the computer allow remote access
		echo Address %%i - Trying access ...
		if not exist "\\%%i\c\windows\System32" ( 
			ECHO Address %%i - Online, but, no access.
			echo %%i >> bloqueada.txt
			) else ( 

			:: SHUTDOWN !
           		 psexec.exe \\%%i -s -u gti -p 6feira*13 shutdown -s -t 00
			echo %%i >> desligado.txt)))