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
export PVERSION_LIBOPING="<%= packageSoftwareVersion %>" &&



### Liboping
# CheckURI: http://verplant.org/liboping/#download
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="liboping" &&
export PVERSION="$PVERSION_LIBOPING" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://verplant.org/liboping/files/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Don't treat warnings as errors
wget http://source.a2o.si/patches/liboping-ignore-warnings.diff &&
patch -p0 < liboping-ignore-warnings.diff &&

wget http://source.a2o.si/patches/liboping-no-setcap.diff &&
patch -p1 < liboping-no-setcap.diff &&

./configure --prefix=/usr/local &&
make &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
