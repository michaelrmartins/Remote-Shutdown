@echo off
:: Remote Shutdown 1.0

:: Michael Martins - 2022 
:: ---------  Changelog  ---------
:: -
:: > 18/07/2021 - Inicio / Criação

:: Execution
:: for /F %%i in (IP.txt) do start EXECUTAR.cmd %%i & sleep 2

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

			:: Verify if the Bginfo it is instaled
			:: C:\WINDOWS\gti_heaa\BGInfo_HEAA < This is the default path instalation on remote station
			if not exist "\\%%i\admin$\gti_heaa\BGInfo_HEAA\bginfo.exe" ( 

			:: Installing ...
			robocopy d:\gti\bginfo\gti_heaa \\%%i\admin$\gti_heaa /S /R:0 /W:2
			robocopy D:\gti\bginfo\gti_heaa\BGInfo_HEAA "\\%%i\c$\ProgramData\microsoft\Windows\Start Menu\Programs\StartUp" bginfo.exe-atalho.lnk /R:0 /W:2
			ECHO Address %%i - Success!.
			echo %%i >> instalado.txt
			) else ( 
			echo %%i - has already been installed 
			echo %%i >> instalado.txt

		) 
		)
	)
)