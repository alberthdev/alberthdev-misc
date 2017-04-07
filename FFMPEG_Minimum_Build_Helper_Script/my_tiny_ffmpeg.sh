#!/bin/bash
# My Tiny FFMPEG
# Script to simply build a tiny, static version of FFMPEG, per spec:
# https://github.com/alberthdev/alberthdev-misc/wiki/Build-your-own-tiny-FFMPEG
# 
# Usage:
#   Simply run this script, and it will build FFMPEG within your
#   current directory, given the same options as above.
#   
#   It will save everything to a subdirectory called FFMPEGBuild.
#   Note that the build itself should only be run once, since the build
#   will delete all prior builds when started.
#   
#   You should run this script with the Python script next to it -
#   it will need it to build FFMPEG.

FFMPEG_URL="http://ffmpeg.org/releases/ffmpeg-3.2.4.tar.bz2"
MAKEOPTS="-j4"

becho() { echo -e "\e[1m$@\e[0m"; }

doexec() {
	becho " EXEC  >> $@"
	$@
}

doexecw() {
	becho " EXECW >> $@"
	sleep 1
	$@
	printf "Press ENTER > "
	read
}

doexecl() {
	becho " EXECL >> $@"
	sleep 2
	$@ | less
}

becho "My Tiny FFMPEG (Builder)"
becho "========================"
becho "Script notes:"
while read in; do becho "$in"; done < <(cat "$0" | grep '^#' | sed '/\/bin\/bash/d')
becho "Will download and build FFMPEG from this URL:"
becho "  $FFMPEG_URL"
becho "Make options: $MAKEOPTS"
becho "Press ENTER to start build."
read

becho "== Setting up build environment =="
doexec mkdir -p FFMPEGBuild
doexec rm -rf FFMPEGBuild/*
doexec cd FFMPEGBuild

becho "== Downloading + Building x264 =="
doexec mkdir -p x264
doexec cd x264
doexec wget "ftp://ftp.videolan.org/pub/x264/snapshots/last_x264.tar.bz2"
doexec tar -xf last_x264.tar.bz2
doexec cd x264-snapshot-*
doexec mkdir build
doexec cd build
doexec ../configure --enable-static --disable-cli --disable-gpl --disable-opencl --disable-avs --disable-swscale --disable-lavf --disable-ffms --disable-gpac --disable-lsmash --disable-thread
doexec make $MAKEOPTS
doexec cp libx264.a x264_config.h ../*.h ../../
doexec cd ../../../

becho "== Downloading + Building FFMPEG =="
doexec mkdir -p ffmpeg
doexec cd ffmpeg
doexec wget "$FFMPEG_URL"
doexec tar -xf ffmpeg-*.tar.bz2
doexec cd ffmpeg-*
doexec cp ../../../get_autodetect_options.py .
doexec mkdir build
doexec cd build
doexec ../configure --disable-all `python ../get_autodetect_options.py --opts` --enable-ffmpeg --enable-small --enable-avcodec --enable-avformat --enable-avfilter --enable-swresample --enable-swscale --enable-decoder=h264 --enable-encoder=rawvideo,libx264 --enable-parser=h264 --enable-protocol=file --enable-demuxer=mov --enable-muxer=rawvideo,mp4 --enable-filter=scale --enable-gpl --enable-libx264 --extra-cflags="-I../../../x264" --extra-cxxflags="-I../../../x264" --extra-ldflags="-L../../../x264"
doexec make $MAKEOPTS

becho "== Build Complete - Displaying Results =="
doexecw ls -lh ffmpeg
doexecw ldd ffmpeg
doexecl ./ffmpeg -version
doexecl ./ffmpeg -buildconf
doexecl ./ffmpeg -formats
doexecl ./ffmpeg -devices
doexecl ./ffmpeg -codecs
doexecl ./ffmpeg -decoders
doexecl ./ffmpeg -encoders
doexecl ./ffmpeg -bsfs
doexecl ./ffmpeg -protocols
doexecl ./ffmpeg -filters
doexecl ./ffmpeg -pix_fmts
doexecl ./ffmpeg -layouts
doexecl ./ffmpeg -sample_fmts
doexecl ./ffmpeg -colors
doexecl ./ffmpeg -hwaccels

becho "== Returning =="
doexec cd ../../../
