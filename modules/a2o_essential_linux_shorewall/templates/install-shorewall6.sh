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



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SHOREWALL="<%= softwareVersion %>" &&
export PVERSION_MAJ=`echo "$PVERSION_SHOREWALL" | cut -d'.' -f1,2` &&
export PVERSION_MED=`echo "$PVERSION_SHOREWALL" | cut -d'.' -f1,2,3` &&



### Shorewall
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="shorewall" &&
export PVERSION="$PVERSION_SHOREWALL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="http://france.shorewall.net/pub/$PVERSION_MAJ/shorewall-$PVERSION_MED/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./install.sh &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
