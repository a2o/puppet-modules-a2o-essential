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
export PVERSION_SW_PUPPET="<%= softwareVersion %>" &&
export PVERSION_SW=`echo "$PVERSION_SW_PUPPET" | sed -e 's/_/-/'` &&
export PVERSION_SW_DL=`echo "$PVERSION_SW_PUPPET" | sed -e 's/[._]/-/g'` &&



### EBtables
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="ebtables" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-v$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://downloads.sourceforge.net/sourceforge/ebtables/ebtables/ebtables-$PVERSION_SW_DL/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
