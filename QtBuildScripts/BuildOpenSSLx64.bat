@echo off
echo  * Configuring...
perl Configure VC-WIN64A --prefix=C:\OpenSSL-win64

(
echo  * Configuring static compile (with NASM)...
ms\do_win64a
)

echo  * Building...
nmake -f ms\nt.mak

echo  * Installing...
nmake -f ms\nt.mak install