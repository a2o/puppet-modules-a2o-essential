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
export PVERSION_LIBXSLT="<%= packageSoftwareVersion %>" &&



### libxslt
# CheckURI: ftp://fr.rpmfind.net/pub/libxml/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="libxslt" &&
export PVERSION="$PVERSION_LIBXSLT" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="ftp://fr.rpmfind.net/pub/libxml/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
