@echo off

set ORIGINAL_DIR=%CD%

set QT_VERSION=5.12.0
set SOURCE_DIR=C:\Users\Win10\Downloads\qt-everywhere-src-5.12.0
set PATCH_PATH=C:\Users\Win10\Downloads\patch-2.5.9-7-bin\bin

:: Change this if you want to build against LibreSSL v2.7 instead
:: LIBRESSL_VERSION_2P8=1 means build with LibreSSL v2.8
:: LIBRESSL_VERSION_2P8=0 means build with LibreSSL v2.7 (or even lower)
set LIBRESSL_VERSION_2P8=1

@echo == Qt + LibreSSL Patching Script ==

:: Set required paths
set PATH=%PATCH_PATH%;%PATH%

@echo == Displaying settings...

@echo Patch Settings:
@echo   Source Directory:  %SOURCE_DIR%
@echo   Required Qt Ver:   %QT_VERSION%
@echo   --------------------------------------------
@echo   Patch PATH:        %PATCH_PATH%
@echo   PATH Variable:     %PATH%
@echo   LibreSSL v2.8:     %LIBRESSL_VERSION_2P8% ^(1=yes, 0=no^)

@echo ^>^> Are you sure you wish to patch the source?
@echo ^>^> Note that you can only patch this once on a clean source tree
@echo ^>^> for Qt v%QT_VERSION%.
pause

@echo == Preparing to patch...

cd %SOURCE_DIR%

@echo == Patching LibreSSL API feature disable detection...
patch -p0 < %ORIGINAL_DIR%\libressl-disable-1.1-APIs.patch

if "%LIBRESSL_VERSION_2P8%" == "1" (
	@echo == Patching LibreSSL v2.8 const fix...
	patch -p0 < %ORIGINAL_DIR%\libressl-const-bio.patch
) else (
	@echo == Skipping patch for LibreSSL v2.8 const fix ^(config set for v2.7 and lower^)...
)

cd %ORIGINAL_DIR%