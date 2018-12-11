@echo off

set ORIGINAL_DIR=%CD%

set SOURCE_DIR=C:\Users\Win10\Downloads\libressl-2.8.2
set BUILD_BASE_DIR=C:\build
set INSTALL_DIR_PREFIX=C:\LibreSSL-2.8.2-win

set CMAKE_GENERATOR=Visual Studio 14 2015
set CMAKE_TARGET=v140_xp
set VC_VARS_VERSION=14.0

setlocal EnableDelayedExpansion

set arch=%1

if "%arch%" == "" (
	echo Usage: BuildLibreSSL.bat Arch
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
) else {
	echo ERROR: Invalid Arch specified: %arch%
	echo Usage: BuildLibreSSL.bat Arch
	echo ARCH should be 32 or 64.
	exit /b
)

:set_build_install_dir
set LIBRESSL_BUILD_DIR=%BUILD_BASE_DIR%\LibreSSL-2.8.2-win%arch%
set LIBRESSL_INSTALL_DIR=%INSTALL_DIR_PREFIX%%arch%

@echo == LibreSSL Static Build Script ==
@echo ^^!^^! Make sure you have applied your static patches for LibreSSL^^!
@echo ^^!^^! If you haven't applied them yet, please do so for your source
@echo ^^!^^! tree before building. Otherwise, you'll end up having to
@echo ^^!^^! rebuild LibreSSL again for static Qt^^!
@echo ^^!^^!
@echo ^^!^^! Will continue in a few seconds...

timeout /T 5

@echo == Detecting environment...

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT set HOST_ARCH=x86
if %OS%==64BIT set HOST_ARCH=amd64

@echo == Loading VS environment...

::call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat" -arch=%TARGET_ARCH% -host_arch=%HOST_ARCH% -vcvars_ver=%VC_VARS_VERSION% -no_logo

:: Workaround for broken MS garbage
set VCTargetsPath=C:\Program Files (x86)\MSBuild\Microsoft.Cpp\v4.0\v140

@echo == Displaying settings...

@echo Build Settings:
@echo   Source Directory:  %SOURCE_DIR%
@echo   Build Directory:   %LIBRESSL_BUILD_DIR%
@echo   Install Directory: %LIBRESSL_INSTALL_DIR%
@echo   CMake Generator:   %CMAKE_GENERATOR%
@echo   CMake Target:      %CMAKE_TARGET%
@echo   VC Vars Version:   %VC_VARS_VERSION%
@echo   --------------------------------------------
@echo   Host Arch:         %HOST_ARCH%
@echo   Target Arch:       %TARGET_ARCH%
@echo   --------------------------------------------
@echo Environment Settings:
@echo   VCTargetsPath:     %VCTargetsPath%

@echo == Preparing to start...

if not exist "%BUILD_BASE_DIR%\" mkdir %BUILD_BASE_DIR%
if not exist "%LIBRESSL_BUILD_DIR%\" mkdir %LIBRESSL_BUILD_DIR%

cd %LIBRESSL_BUILD_DIR%

@echo == Configuring...
cmake -G "%CMAKE_GENERATOR%" -T %CMAKE_TARGET% -DCMAKE_INSTALL_PREFIX:PATH=%LIBRESSL_INSTALL_DIR% %SOURCE_DIR%

@echo == Building...
msbuild ALL_BUILD.vcxproj

@echo == Running tests...
msbuild RUN_TESTS.vcxproj

@echo == Installing...
msbuild INSTALL.vcxproj

cd %ORIGINAL_DIR%