# Qt Quick Static Compilation Patches

## Introduction
These patches are for making Qt Quick truly static. In the past,
Qt Quick was always dynamic, resulting in static builds that
required additional DLLs and Qt Quick plugin files.

With newer version of Qt, Qt Quick is slowly adding static support.
That said, static support is very iffy, and those DLLs and plugins
are still needed for the static build to work.

These patches attempt to fix this problem, and allow everything
(including the necessary Qt Quick plugins) to be included in one
executable.

Relevant Qt bug reports:
[QTBUG-35754](https://bugreports.qt.io/browse/QTBUG-35754) and
[QTBUG-28357](https://bugreports.qt.io/browse/QTBUG-28357)

## Patches
These patches are available:

 * **Qt v5.6**:
   * **`Qt560-StaticFixBundle.patch`** - this is the patch you should
     probably use. Contains all fixes needed for static compilation
     to work.
   * **`Qt560-StaticFixBundle.patch-orig`** - original patch created
     from diffing the two source trees, the original and the fixed
     source. This is only here for reference - do NOT attempt to apply!
 * **Qt v5.7 Beta**:
   * **`Qt57Dev-QtQuickControls-StaticQmlResourceFilesFix-AllPatchesBundled.patch** -
     this is the patch you should probably use. Contains all fixes
     needed for static compilation to work.
   * **`Qt57Dev-QtQuickControls-StaticQmlResourceFilesFix.patch`** -
     this patch only fixes QML resource file resolution within Qt
     Quick.
   * **`Qt57Dev-QtQuickControls-StaticQmlResourceFilesFix.patch-orig`** -
     original patch created from diffing the two source trees, the
     original and the fixed source. This is only here for reference -
     do NOT attempt to apply!
   * **`Qt57Dev-StaticQmlResourceFilesFix.patch`** - this patch fixes
     including QML files into a resource when building statically.
     See patch for more details.
   * **`Qt57Dev-StaticQmlResourceUsageCPPFix.patch`** - this patch fixes
     using the resources when built statically. See patch for more details.
