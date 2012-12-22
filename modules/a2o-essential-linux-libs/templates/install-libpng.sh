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
export PVERSION_LIBPNG="<%= packageSoftwareVersion %>" &&



### libpng
# CheckURI: http://www.libpng.org/pub/png/libpng.html
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="libpng" &&
export PVERSION="$PVERSION_LIBPNG" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://downloads.sourceforge.net/sourceforge/libpng/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
./configure &&
make -j 2 &&
make install &&
rm -f /usr/lib64/libpng* &&
ldconfig &&
cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
