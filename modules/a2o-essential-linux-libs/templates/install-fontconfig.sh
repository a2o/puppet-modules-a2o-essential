#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) Bostjan Skufca                                            #
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
export PVERSION_FONTCONFIG="<%= packageSoftwareVersion %>" &&



### Fontconfig
# CheckURI: http://fontconfig.org/release/
# Req: FreeType2, expat
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="fontconfig" &&
export PVERSION="$PVERSION_FONTCONFIG" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://fontconfig.org/release/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make -j 2 &&

# WORKAROUND
# 2.8.0 on 32bit slack, after compilation install would not work correctly for the first time
# Also, while doing initial build there is an error for every version.
#   /usr/local/bin/fc-cache: error while loading shared libraries: libfontconfig.so.1: cannot open shared object file: No such file or directory
#
# We can either:
# - install it twice with ldconfig in between
# - export LD path to search for 'make install' - YES, cleaner
export LD_LIBRARY_PATH=`pwd`/src/.libs &&

make install &&
unset LD_LIBRARY_PATH &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
