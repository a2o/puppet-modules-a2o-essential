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
export PVERSION_LIBNETFILTER_CONNTRACK="<%= packageSoftwareVersion %>" &&



### libnetfilter_conntrack
# CheckURI: http://www.netfilter.org/projects/libnetfilter_conntrack/downloads.html
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="libnetfilter_conntrack" &&
export PVERSION="$PVERSION_LIBNETFILTER_CONNTRACK" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.bz2" &&
export PURI="http://www.netfilter.org/projects/libnetfilter_conntrack/files/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export PKG_CONFIG_PATH='/usr/local/lib/pkgconfig' &&

./configure &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
