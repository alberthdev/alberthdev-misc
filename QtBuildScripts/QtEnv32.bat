@ECHO OFF
REM Set up \Microsoft Visual Studio 2015, where <arch> is \c amd64, \c x86, etc.
CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
REM SET _ROOT=C:\Users\Win7x64\Documents\Qt56Beta
SET _ROOT=C:\Users\Win7x64\Documents\Qt56
SET PATH=C:\jom;%_ROOT%\qtbase\bin;%_ROOT%\build\qtbase\bin;%_ROOT%\gnuwin32\bin;C:\Program Files (x86)\NASM;%PATH%
REM Uncomment the below line when using a git checkout of the source repository
REM SET PATH=%_ROOT%\qtrepotools\bin;%PATH%
SET QMAKESPEC=win32-msvc2015
SET _ROOT=