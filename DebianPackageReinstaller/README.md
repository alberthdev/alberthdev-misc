# Debian Package Reinstaller

This is a simple Python script to reinstall Debian, package by package.
Reinstalling package-by-package is a rudimentary (but acceptible) way
of repairing and/or reinstalling an existing Debian system.

This has been tested on Jessie. This script may work on newer/older
version of Debian, as well as other Debian-based systems as well.
(Ubuntu and Mint are included!)

## Requirements
 * Debian (or Debian-based) system. (Ubuntu, Mint, and friends are
   included!)
   
 * This is a Python script, so a suitable Python interpreter is required
   in order to run it. Note that you can use Python 2 or Python 3.
   (It was originally written in Python 3, but this script uses Python 2
   friendly syntax.)
   
 * Bash (or similar) shell. You will need to create a environment
   variable that the Python script will use to install the package.
   
 * apt-get/dpkg for installing packages. (This should be already
   installed if you're using a Debian or Debian-based system.)
   
 * Internet connection. (If you don't have one, you might be able to
   get away with storing your package archives in
   `/var/cache/apt/archives`.
   
 * Free space for a full system reinstall.
 
## How to Use
 * Download the script:
   [reinstall_debian.py][script]
   (You will need to click the "Raw" button to actually download it!)

 * Start your system in "recovery" (or "rescue") mode. This should be an
   option when booting your system. If not, you should terminate as many
   non-essential programs on your system as possible before starting the
   reinstall. (Yes, this includes your desktop! You should be in the
   raw console, e.g. CTRL-ALT-F1, for the duration of this reinstall.)

 * Fetch your package list and set your environment variable:
   
   `export PKGLIST=$(dpkg --get-selections | grep -v deinstall | cut -f1)`
   
 * Run the script (as root):
   
   `python reinstall_debian.py`
   
   If you have Python 3, you can alternatively run:
   
   `python3 reinstall_debian.py`
   
 * Wait. If there are any errors, make sure to correct them.
 
 * Once you're done, reboot your system immediately. Hopefully your
   system will be back to normal!

## Technical Details
This script basically chunks out the package reinstallation, and
attempts to mitigate some issues related to it.

One error that may occur during reinstallation is this:

    Couldn't configure [...], probably a dependency cycle.

The solution was to remove the package from the list of packages to
reinstall, and continue until problematic packages are removed.

## Important Notes
This script will likely end up reinstalling GRUB (`grub-pc` on Jessie).
When this occurs, it should succeed - unless you did something weird.

If you are installing GRUB2 to a partition, see [this wiki page][wikip]
for details on what to do before and after running this script.

[script]: reinstall_debian.py
[wikip]: ../../../wiki/Installing-GRUB2-to-a-Partition#reinstallingupgrading-grub2
