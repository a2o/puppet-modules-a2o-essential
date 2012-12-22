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
export PVERSION_SW_DIST="<%= softwareVersionDist %>" &&
export PDESTDIR="<%= destDir %>" &&



### Java JRE
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="jre" &&
export PVERSION="$PVERSION_SW" &&
export PVERSION_DIST="$PVERSION_SW_DIST" &&
export PDIR="$PNAME$PVERSION" &&
export PFILE="$PNAME-$PVERSION_DIST-linux-x64.tar.gz" &&
export PURI="http://source.a2o.si/source-packages/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&
chown root.root -R ./$PDIR &&

rm -rf $PDESTDIR &&
mv $PDIR $PDESTDIR &&



exit 0
