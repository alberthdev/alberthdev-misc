#!/usr/bin/env python3
# Debian Package Reinstaller
# Requires Python 3

import os
import sys
import subprocess
import time

pkglist = os.environ.get("PKGLIST")

chunksize = 200

if not pkglist:
    print("ERROR: PKGLIST not defined.")
    print("Run this command in order to create this required variable:")
    print("export PKGLIST=$(dpkg --get-selections | grep -v deinstall | cut -f1)")
    print("Then re-run this program.")
    sys.exit(1)

ignored_pkgs = []
pkglist = [x.strip() for x in pkglist.split() if x.strip()]

total_pkgs = len(pkglist)
installed_pkgs = 0

print(" * Need to install %d packages." % total_pkgs)
time.sleep(1)
while len(pkglist) > 0:
    print(" * Installation progress: %d/%d packages, %.2f%%" % (installed_pkgs, total_pkgs, 100.0 * installed_pkgs / total_pkgs))
    for i in range(chunksize, 0, -1):
        pkglist_chunk = pkglist[:i]
        if len(pkglist_chunk) == 0:
            continue
        for p in ignored_pkgs:
            if p in ignored_pkgs and p in pkglist_chunk:
                pkglist_chunk.remove(p)
        cmd = ["apt-get", "-q", "-y", "--force-yes", "install", "--reinstall"]
        cmd += pkglist_chunk
        try:
            print(" * Installing %d packages: %s..%s" % (len(pkglist_chunk), pkglist_chunk[0], pkglist_chunk[-1]))
            output = subprocess.check_output(cmd, stderr=subprocess.STDOUT)
            #print(" *   " + "\n *   ".join(output.decode().split("\n")))
            print(" * Successfully installed packages!")
            for pkg in pkglist_chunk:
                installed_pkgs += 1
                pkglist.remove(pkg)
            break
        except subprocess.CalledProcessError as e:
            print(" ! apt-get exited with error %d" % e.returncode)
            print(" ! Output follows:")
            err_output = e.output.decode()
            print(" !   " + "\n !   ".join(err_output.split("\n")))
            if "Couldn't configure" in err_output:
                # E: Couldn't configure bash-completion:amd64, probably a dependency cycle.
                err_msg_pc = [ x for x in err_output.split("\n") if x.endswith("dependency cycle.") ]
                if len(err_msg_pc) > 0:
                    err_msg_pc = err_msg_pc[0].split(" ")
                    if len(err_msg_pc) > 3:
                        problem_pkg = err_msg_pc[3].split(":")[0]
                        print(" ! Detected strange dependency error, removing problematic package %s..." % problem_pkg)
                        ignored_pkgs.append(problem_pkg)
                        pkglist.remove(problem_pkg)
            if i > 1:
                print(" ! Retrying with %d packages..." % (i-1))
            else:
                print(" ! Problematic package %s added to ignored list.")
                ignored_pkgs += pkglist_chunk
                for pkg in pkglist_chunk:
                    pkglist.remove(pkg)

if len(ignored_pkgs) > 0:
    print(" ! Ignored packages: %s" % ", ".join(ignored_pkgs))
