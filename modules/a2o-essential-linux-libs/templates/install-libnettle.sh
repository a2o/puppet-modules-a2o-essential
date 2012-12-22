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
export PVERSION_LIBNETTLE="<%= packageSoftwareVersion %>" &&



### libnettle
# CheckURI: http://www.lysator.liu.se/~nisse/archive/
# ReqBy: gnutls
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="nettle" &&
export PVERSION="$PVERSION_LIBNETTLE" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.lysator.liu.se/~nisse/archive/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --enable-shared &&
make &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
