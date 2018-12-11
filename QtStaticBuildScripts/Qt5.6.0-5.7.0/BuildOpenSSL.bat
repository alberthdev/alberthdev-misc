@echo off
echo  * Configuring...
perl Configure VC-WIN32 --prefix=C:\OpenSSL-win32

(
echo  * Configuring static compile...
ms\do_ms
)

echo  * Configuring NASM setup...
ms\do_nasm

echo  * Building...
nmake -f ms\nt.mak

echo  * Installing...
nmake -f ms\nt.mak install