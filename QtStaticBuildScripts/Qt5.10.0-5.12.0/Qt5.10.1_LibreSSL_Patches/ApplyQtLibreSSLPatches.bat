@echo off

set ORIGINAL_DIR=%CD%

set QT_VERSION=5.10.1
set SOURCE_DIR=C:\Users\Win10\Downloads\qt-everywhere-src-5.10.1
set PATCH_PATH=C:\Users\Win10\Downloads\patch-2.5.9-7-bin\bin

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

@echo ^>^> Are you sure you wish to patch the source?
@echo ^>^> Note that you can only patch this once on a clean source tree
@echo ^>^> for Qt v%QT_VERSION%.
pause

@echo == Preparing to patch...

cd %SOURCE_DIR%

@echo == Patching...
patch -p0 < %ORIGINAL_DIR%\libressl-compat.patch
patch -p0 < %ORIGINAL_DIR%\libressl-no-opensslv11.patch

cd %ORIGINAL_DIR%