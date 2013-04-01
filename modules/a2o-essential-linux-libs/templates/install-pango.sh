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
export PVERSION_PANGO="<%= packageSoftwareVersion %>" &&



### Pango
# CheckURI: http://ftp.gnome.org/pub/GNOME/sources/pango/
# Req: cairo, glib2
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="pango" &&
export PVERSION="$PVERSION_PANGO" &&
export PVERSION_MAJOR=`echo $PVERSION | cut -d. -f1,2` &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.xz" &&
export PURI="http://ftp.gnome.org/pub/GNOME/sources/pango/$PVERSION_MAJOR/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig"

./configure --without-x &&
make -j 2 &&
make install &&
ldconfig &&

unset PKG_CONFIG_PATH &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
