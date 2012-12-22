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



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SW="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### MongoDB
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="mongodb" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-src-r$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://downloads.mongodb.org/src/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

scons --prefix=$PDESTDIR install &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
