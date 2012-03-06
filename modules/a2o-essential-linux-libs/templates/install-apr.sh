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
export PVERSION_APR="<%= packageSoftwareVersion %>" &&



### Apache portable runtime (APR)
# CheckURI: http://apr.apache.org/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="apr" &&
export PVERSION="$PVERSION_APR" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.bz2" &&
export PURI="http://www.apache.org/dist/apr/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
./configure &&
make -j 2 &&
make install &&
cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
