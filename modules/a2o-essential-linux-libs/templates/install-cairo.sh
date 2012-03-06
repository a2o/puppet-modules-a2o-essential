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
# Authors: Bostjan Skufca <bostjan@a2o.si>                                #
###########################################################################



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_CAIRO="<%= packageSoftwareVersion %>" &&



### cairo
# CheckURI: http://cairographics.org/releases/
# Req: pixman, fontconfig, libpng, pkg-config
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="cairo" &&
export PVERSION="$PVERSION_CAIRO" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://cairographics.org/releases/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&

export PKG_CONFIG_PATH='/usr/local/lib/pkgconfig' &&

./configure &&
make -j 2 &&
make install &&
ldconfig &&

unset PKG_CONFIG_PATH &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
