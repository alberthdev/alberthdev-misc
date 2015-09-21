# HexChat - Debian Stretch To Jessie Package Converter

This is a simple shell script to convert a Debian Stretch HexChat
package to a Jessie-compatible one. The stretch package is
backwards-compatible with Jessie, but a dependency must be renamed for
the package to install. The script provided here automates the process.

## Requirements
 * This is a shell script, so a suitable shell is required to run it.
 * dpkg-deb for extracting and re-creating the package.
 * sed for replacing dependencies within the Debian dependency control
   file.
 * Standard commands: cat, mv, echo
 
## How to Use
 * Download the script:
   [convert_hexchat_stretch_to_jessie.sh](convert_hexchat_stretch_to_jessie.sh)
   
 * Download hexchat from here:
     https://packages.debian.org/stretch/hexchat
    
 * Change OLD_PKG and NEW_PKG to match the Debian package file name
   from the packages site. I recommend that NEW_PKG be slightly
   different, e.g. old_first_part_JESSIE.deb.
   
 * Run the script. You should now have a modified package.
   
 * Download hexchat-common from here:
     https://packages.debian.org/stretch/hexchat-common
   
 * Install the hexchat-common Debian package.
   
 * Install the new, modified hexchat Debian package. Done!

## Technical Details
This script basically changes the libproxy1v5 dependency in Debian
stretch's hexchat to simply libproxy1, which is the same library in
Debian jessie, but under a different name.

When the package is extracted with dpkg-deb, the script will modify the
extracted DEBIAN/control file and replace the libproxy1v5 dependency
with jessie-compatible libproxy1 dependency.

Once done, it simply re-builds the package from the extracted (and now
modified) directory.
