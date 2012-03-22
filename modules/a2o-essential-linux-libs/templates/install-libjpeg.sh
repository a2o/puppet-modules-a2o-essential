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
export PVERSION_LIBJPEG="<%= packageSoftwareVersion %>" &&



### libjpeg
# CheckURI: http://www.ijg.org/files/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="jpegsrc" &&
export PVERSION="$PVERSION_LIBJPEG" &&
export PDIR="jpeg-$PVERSION" &&
export PFILE="$PNAME.v$PVERSION.tar.gz" &&
export PURI="http://www.ijg.org/files/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --enable-shared --enable-static &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0