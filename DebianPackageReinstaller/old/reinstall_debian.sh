#!/bin/bash
PKGLIST=$(dpkg --get-selections | grep -v deinstall | cut -f1)
for PKG in $PKGLIST; do
    echo " * Reinstalling package: $PKG"
    apt-get -qq install --reinstall $PKG
done
