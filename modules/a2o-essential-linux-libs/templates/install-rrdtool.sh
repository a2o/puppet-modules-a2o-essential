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
export PVERSION_RRDTOOL="<%= packageSoftwareVersion %>" &&



### rrdtool
# CheckURI: http://oss.oetiker.ch/rrdtool/pub/?M=D
# Req: cairo, pango, intltool, libxml2
# ReqBy: ganglia (gmetad), symon, collectd
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="rrdtool" &&
export PVERSION="$PVERSION_RRDTOOL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://oss.oetiker.ch/rrdtool/pub/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&

export PKG_CONFIG_PATH='/usr/local/lib/pkgconfig' &&

./configure --prefix=/usr/local --disable-perl --disable-ruby --disable-lua &&
make -j 2 &&
make install &&
ldconfig &&

unset PKG_CONFIG_PATH &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
