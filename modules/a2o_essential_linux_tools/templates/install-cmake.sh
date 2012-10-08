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
export PVERSION_SW="<%= softwareVersion %>" &&
export PVERSION_SW_MAJOR=`echo "$PVERSION_SW" | cut -d'.' -f1,2` &&



### cmake
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="cmake" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cmake.org/files/v$PVERSION_SW_MAJOR/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
