@echo off

set ORIGINAL_DIR=%CD%

set SOURCE_DIR=C:\Users\Win10\Downloads\qt-everywhere-src-5.12.0
set BUILD_BASE_DIR=C:\build

set QT_PLATFORM=win32-msvc2015
set VC_VARS_VERSION=14.0

setlocal EnableDelayedExpansion

set arch=%1

if "%arch%" == "" (
	echo Usage: BuildStaticQt.bat Arch
	echo ARCH should be 32 or 64.
	exit /b
)

if "%arch%" == "32" (
	set TARGET_ARCH=x86
	goto set_build_install_dir
)

if "%arch%" == "64" (
	set TARGET_ARCH=amd64
	set CMAKE_GENERATOR=%CMAKE_GENERATOR% Win64
	goto set_build_install_dir
) else (
	echo ERROR: Invalid Arch specified: %arch%
	echo Usage: BuildStaticQt.bat Arch
	echo ARCH should be 32 or 64.
	exit /b
)

:set_build_install_dir
set QT_BUILD_DIR=%BUILD_BASE_DIR%\Qt5.12.0-win%arch%
if %arch% == 32 (
	set QT_INSTALL_DIR=C:\Qt\Qt5.12.0-static
) else (
	set QT_INSTALL_DIR=C:\Qt\Qt5.12.0x64-static
)

@echo == Qt Static Build Script ==

@echo == Detecting environment...

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT set HOST_ARCH=x86
if %OS%==64BIT set HOST_ARCH=amd64

@echo == Loading VS environment...

::call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat" -arch=%TARGET_ARCH% -host_arch=%HOST_ARCH% -vcvars_ver=%VC_VARS_VERSION% -no_logo

:: Workaround for broken MS garbage
set VCTargetsPath=C:\Program Files (x86)\MSBuild\Microsoft.Cpp\v4.0\v140

:: Set required Qt paths
set _ROOT=%QT_BUILD_DIR%
set PATH=C:\jom;%_ROOT%\qtbase\bin;%_ROOT%\gnuwin32\bin;%PATH%
set _ROOT=

@echo == Displaying settings...

@echo Build Settings:
@echo   Source Directory:  %SOURCE_DIR%
@echo   Build Directory:   %QT_BUILD_DIR%
@echo   Install Directory: %QT_INSTALL_DIR%
@echo   Qt Platform:       %QT_PLATFORM%
@echo   VC Vars Version:   %VC_VARS_VERSION%
@echo   --------------------------------------------
@echo   Host Arch:         %HOST_ARCH%
@echo   Target Arch:       %TARGET_ARCH%
@echo   --------------------------------------------
@echo   PATH Variable:     %PATH%
@echo Environment Settings:
@echo   VCTargetsPath:     %VCTargetsPath%

@echo == Preparing to start...

if not exist "%BUILD_BASE_DIR%\" mkdir %BUILD_BASE_DIR%
if not exist "%QT_BUILD_DIR%\" mkdir %QT_BUILD_DIR%

cd %QT_BUILD_DIR%

@echo == Configuring...
call %SOURCE_DIR%\configure -opensource -confirm-license^
	-platform %QT_PLATFORM%^
	-debug-and-release^
	-ssl -openssl -openssl-linked ^
	-opengl dynamic^
	-static -static-runtime^
	-no-compile-examples -nomake examples^
	-L C:\LibreSSL-2.8.2-win%arch%\lib OPENSSL_LIBS="-LC:\LibreSSL-2.8.2-win%arch%\lib -lssl -lcrypto"^
	-I C:\LibreSSL-2.8.2-win%arch%\include^
	-prefix %QT_INSTALL_DIR%

set exitcode=%errorlevel%
if %exitcode% neq 0 (
	@echo Exiting due to error code %exitcode%.
	cd %ORIGINAL_DIR%
	exit /b %exitcode%
)

@echo == Building...
jom

set exitcode=%errorlevel%
if %exitcode% neq 0 (
	@echo Exiting due to error code %exitcode%.
	cd %ORIGINAL_DIR%
	exit /b %exitcode%
)

@echo == Installing...
jom install

set exitcode=%errorlevel%
if %exitcode% neq 0 (
	@echo Exiting due to error code %exitcode%.
	cd %ORIGINAL_DIR%
	exit /b %exitcode%
)

cd %ORIGINAL_DIR%