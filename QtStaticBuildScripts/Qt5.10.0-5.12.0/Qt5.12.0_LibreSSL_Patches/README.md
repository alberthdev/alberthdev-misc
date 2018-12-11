Qt v5.12.0 LibreSSL Patches
============================
These patches attempt to provide compatability with LibreSSL ~v2.8
(potentially LibreSSL ~v2.7 as well), and are by the Void Linux team
under the license specified in [COPYING.txt](COPYING.txt).

Patch Notes
------------
The patch we use is taken directly from [here][libressl-compat-patch].

Note the commit hash above - this patch is specifically for Qt v5.12.0.

The other patch we use is a LibreSSL v2.8 patch that you can find
[here][libressl-const-bio] (again, note the commit hash).

There are a few changes made to these patches - line corrections (to
shush patch hunk warnings) and fixes to the replacement context (Qt
replaced some function returns from 0 to nullptr). You may diff the
patches provided with their original copies to see the specific
differences.

All of their Qt5 specific patches can be found [here][vl-qt5-patches].

LibreSSL ~v2.7 (and below) Compatability
-----------------------------------------

If you'd like to continue using LibreSSL v2.7 instead, you can change
the following line in ApplyQtLibreSSLPatches.bat from:

    set LIBRESSL_VERSION_2P8=1

to:

    set LIBRESSL_VERSION_2P8=0

This will suppress any patches from being made for compatability with
LibreSSL v2.8.

[libressl-compat-patch]: https://github.com/void-linux/void-packages/blob/845f11032a4d886d608cf83ab7409c97712f5070/srcpkgs/qt5/patches/0022-libressl-compat.patch
[libressl-const-bio]: https://github.com/void-linux/void-packages/blob/95f32618e214ca322ef88fbab4947d40f7f5183a/srcpkgs/qt5/patches/libressl-const-bio.patch
[vl-qt5-patches]: https://github.com/void-linux/void-packages/tree/master/srcpkgs/qt5/patches