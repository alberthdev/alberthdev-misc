:: ICU disabled
..\configure -opensource -confirm-license^
 -debug-and-release -ssl -openssl -opengl dynamic^
 -static -static-runtime -target xp^
 -no-compile-examples -nomake examples^
 -L C:\OpenSSL-win64\lib -l libeay32 -l ssleay32 -I C:\OpenSSL-win64\include^
 -prefix C:\Qt\Qt5.6.0x64-static