# alberthdev-misc
Miscellaneous things I've created that are not big enough for a
dedicated repository, and are not small (or useless) enough for a Gist!

## [Wiki](../../wiki/)
The wiki includes some guides and gotchas that I've created or found
over the years. They may have links to the code available here.

### [➡ Explore the Wiki](../../wiki)

## Subprojects:

 * [HexChat - Debian Stretch To Jessie Package Converter][p1] -
   a simple shell script to convert a Debian Stretch HexChat package to
   a Jessie-compatible one. The stretch package is backwards-compatible
   with Jessie, but a dependency must be renamed for the package to
   install. The script provided here automates the process.

 * [Qt Build Scripts][p3] -
   scripts to help with building Qt statically. See the
   [wiki][wiki] for more details. Scripts support Qt v5.6, v5.7,
   and v5.10-v5.12.

   * [Qt QtQuick Static Patches][p2] -
     patches to enable fully static compilation for Qt, whether on
     Windows or other platforms. (This is meant especially for Windows
     for those aiming to distribute a single executable.) Note that
     this still requires the relevant OpenGL/DirectX/Mesa DLLs to run,
     which unfortunately is still a limitation for QtQuick. I recommend
     bundling all three graphics DLLs to maximize compatability on
     all machines!
     
     Currently, patches are provided for Qt v5.6 and v5.7 beta. They are
     from [this issue](https://bugreports.qt.io/browse/QTBUG-35754),
     and modified to support various other modules as well. Future
     versions of Qt will no longer require any additional patches.

 * [Debian Package Reinstaller][p4] -
   script to help with reinstalling all of the Debian packages on a
   Debian or Debian-based system (including Ubuntu and Mint).

[p1]: HexChat_Debian_Stretch_To_Jessie_Package_Converter/
[p2]: QtStaticBuildScripts/Qt5.6.0-5.7.0/QtQuickStaticPatches/
[p3]: QtStaticBuildScripts/
[p4]: DebianPackageReinstaller/
[wiki]: https://github.com/alberthdev/alberthdev-misc/wiki/Building-Qt-v5.6-5.7-Statically-on-Windows
