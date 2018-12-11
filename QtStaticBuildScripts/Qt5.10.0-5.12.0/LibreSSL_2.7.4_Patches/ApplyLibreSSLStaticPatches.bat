@echo off

set ORIGINAL_DIR=%CD%

set SOURCE_DIR=C:\Users\Win10\Downloads\libressl-2.7.4
set PATCH_PATH=C:\Users\Win10\Downloads\patch-2.5.9-7-bin\bin

@echo == LibreSSL Static Patching Script ==

:: Set required paths
set PATH=%PATCH_PATH%;%PATH%
set LIBRESSL_VERSION=2.7.4

@echo == Displaying settings...

@echo Patch Settings:
@echo   Source Directory:        %SOURCE_DIR%
@echo   Required LibreSSL Ver:   %LIBRESSL_VERSION%
@echo   --------------------------------------------
@echo   Patch PATH:              %PATCH_PATH%
@echo   PATH Variable:           %PATH%

@echo ^>^> Are you sure you wish to patch the source?
@echo ^>^> Note that you can only patch this once on a clean source tree
@echo ^>^> for LibreSSL v%LIBRESSL_VERSION%. Once patched, LibreSSL will only build
@echo ^>^> in static mode - you must use a clean source tree to build
@echo ^>^> dynamically with the MSVC runtime library.
pause

@echo == Preparing to patch...

cd %SOURCE_DIR%

@echo == Patching CMakeLists.txt to add static runtime override...
patch -p0 < %ORIGINAL_DIR%\cmakelist-static-runtime-override.patch

@echo == Copying CMake override file for C_FLAGS...
copy %ORIGINAL_DIR%\c_flag_overrides.cmake .\c_flag_overrides.cmake

@echo == Copying CMake override file for CXX_FLAGS...
copy %ORIGINAL_DIR%\cxx_flag_overrides.cmake .\cxx_flag_overrides.cmake

cd %ORIGINAL_DIR%