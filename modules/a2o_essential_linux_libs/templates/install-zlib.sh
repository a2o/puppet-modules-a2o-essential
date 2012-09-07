#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SW="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



# FIXME investigate, because it causes apache and sshd segfaults
### zlib
# CheckURI: http://www.zlib.net/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="zlib" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.zlib.net/$PFILE"

if [ "$PDESTDIR" == "/usr/local" ]; then
    if [ -e /usr/local/lib/libz.so.$PVERSION ]; then
	# This is a fuse against segfaulting of various daemons
	echo
	echo "Skipping zlib because file already exists: /usr/local/lib/libz.so.$PVERSION"
	echo
	exit 0
    fi
fi

rm -rf $PDIR &&
GetUnpackCd &&

# 32-bit only
#./configure &&

CFLAGS="-O3 -fPIC" ./configure --prefix=$PDESTDIR &&
make -j 2 &&
make install &&

if [ "$PDESTDIR" == "/usr/local" ]; then
    rm -f /usr/lib/libz.so.* &&
    rm -f /usr/lib64/libz.so.*
fi &&

ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
