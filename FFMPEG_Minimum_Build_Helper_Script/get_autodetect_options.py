#!/usr/bin/env python3
# This script simply calls "./configure --help", searches
# for options marked with "autodetect", and then changes each
# option to --disable-FEATURE.
# 
# Specifying --opts to this script will simply dump out the
# necessary arguments needed to disable every 3rd party library
# feature available in FFMPEG.

import subprocess
import sys

help_lines = subprocess.check_output(["../configure", "--help"]).decode("utf-8").split("\n")

autodetect_options = []
prev_line = None
for help_line in help_lines:
	help_line = " ".join(help_line.split())
	if "autodetect" in help_line:
		if "--" in help_line:
			autodetect_options.append(help_line.split()[0])
		elif prev_line and "--" in prev_line:
			autodetect_options.append(prev_line.split()[0])
		else:
			print("WARNING: Saw autodetect but couldn't find corresponding option.")
			print("   Line: %s" % help_line)
			print(" P Line: %s" % str(prev_line))
		
	prev_line = help_line

autodetect_options = [ x.replace("enable", "disable") if "enable" in x else x for x in autodetect_options ]

if len(sys.argv) == 2 and sys.argv[1] == "--opts":
	sys.stdout.write(" ".join(autodetect_options))
else:
	print("Autodetect options that need to be disabled:")
	for x in autodetect_options:
		print("  %s" % x)
	
	print("Copy and paste into your configure arguments:")
	print(" ".join(autodetect_options))
