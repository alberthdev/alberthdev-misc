#!/bin/sh
# Script for converting a Debian stretch copy of hexchat to jessie.
# (C) Copyright 2015 Albert Huang.
# License: GPL v3.
# 
# This script basically changes the libproxy1v5 dependency in Debian
# stretch's hexchat to simply libproxy1, which is the same library in
# Debian jessie, but under a different name.
# 
# How to use:
#   Download hexchat from here:
#     https://packages.debian.org/stretch/hexchat
#   
#   Change OLD_PKG and NEW_PKG to match the Debian package file name
#   from the packages site. I recommend that NEW_PKG be slightly
#   different, e.g. old_first_part_JESSIE.deb.
#   
#   Run this script. You should now have a modified package.
#   
#   Download hexchat-common from here:
#     https://packages.debian.org/stretch/hexchat-common
#   
#   Install the hexchat-common Debian package.
#   
#   Install the new, modified hexchat Debian package. Done!
# 

OLD_PKG="hexchat_2.10.2-1+b1_amd64.deb"
NEW_PKG="hexchat_2.10.2-1+b1_amd64_JESSIE.deb"

dpkg-deb -R "$OLD_PKG" tmp_hexchat_deb_pkg

cat tmp_hexchat_deb_pkg/DEBIAN/control | sed 's/libproxy1v5/libproxy1/g' > tmp_hexchat_deb_pkg/DEBIAN/control_mod
mv tmp_hexchat_deb_pkg/DEBIAN/control_mod tmp_hexchat_deb_pkg/DEBIAN/control

dpkg-deb -b tmp_hexchat_deb_pkg "$NEW_PKG"

echo "Install the new Debian package:"
echo "$NEW_PKG"
