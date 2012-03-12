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
export PVERSION_GLIB="<%= packageSoftwareVersion %>" &&



### glib2
# CheckURI: http://ftp.gnome.org/pub/gnome/sources/glib/
# Requires: gettext,libiconv,libffi
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="glib" &&
export PVERSION="$PVERSION_GLIB" &&
export PVERSION_MAJOR=`echo $PVERSION | cut -d. -f1,2` &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.xz" &&
export PURI="http://ftp.gnome.org/pub/gnome/sources/glib/$PVERSION_MAJOR/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&

export PKG_CONFIG_PATH='/usr/local/lib/pkgconfig'  &&

./configure --enable-static --with-libiconv &&
make -j 2 &&
make install &&

unset PKG_CONFIG_PATH &&

ldconfig &&
cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
