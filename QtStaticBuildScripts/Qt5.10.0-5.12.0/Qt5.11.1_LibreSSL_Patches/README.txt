Qt v5.11.1 LibreSSL Patches
============================
These patches attempt to provide compatability with LibreSSL ~v2.7, and
are by the Void Linux team under the license specified in COPYING.txt.

The only patch we use is taken directly from here:
https://github.com/void-linux/void-packages/blob/master/srcpkgs/qt5/patches/libressl-disable-1.1-APIs.patch

The original patch is then modified to replace these lines:

    --- ./qtbase/src/network/ssl/qsslsocket_openssl_symbols_p.h.orig	2018-04-24 10:40:49.121761681 +0200
    +++ ./qtbase/src/network/ssl/qsslsocket_openssl_symbols_p.h	2018-04-24 10:41:43.082843248 +0200
    @@ -232,7 +232,7 @@ BIO *q_BIO_new_mem_buf(void *a, int b);
     int q_BIO_read(BIO *a, void *b, int c);
     Q_AUTOTEST_EXPORT int q_BIO_write(BIO *a, const void *b, int c);
     int q_BN_num_bits(const BIGNUM *a);
    -#if OPENSSL_VERSION_NUMBER >= 0x10100000L
    +#if OPENSSL_VERSION_NUMBER >= 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)
     int q_BN_is_word(BIGNUM *a, BN_ULONG w);
     #else
     // BN_is_word is implemented purely as a

...with these lines instead:

    --- ./qtbase/src/network/ssl/qsslsocket_openssl_symbols_p.h.orig	2018-04-24 10:40:49.121761681 +0200
    +++ ./qtbase/src/network/ssl/qsslsocket_openssl_symbols_p.h	2018-04-24 10:41:43.082843248 +0200
    @@ -232,7 +232,7 @@ BIO *q_BIO_new_mem_buf(void *a, int b);
     int q_BIO_read(BIO *a, void *b, int c);
     Q_AUTOTEST_EXPORT int q_BIO_write(BIO *a, const void *b, int c);
     int q_BN_num_bits(const BIGNUM *a);
     
    -#if QT_CONFIG(opensslv11)
    +#if QT_CONFIG(opensslv11) && !defined(LIBRESSL_VERSION_NUMBER)
     int q_BN_is_word(BIGNUM *a, BN_ULONG w);
     #else // opensslv11
     // BN_is_word is implemented purely as a

This changed from Qt v5.10.x where there were specific C++ code/header
patches to get things working. There are still code/header patches, but
it's much smaller in size mainly due to the improved configuration
setup within Qt's code, resulting in a much smaller patch.

All of their Qt5 specific patches can be found here:
https://github.com/void-linux/void-packages/tree/master/srcpkgs/qt5/patches