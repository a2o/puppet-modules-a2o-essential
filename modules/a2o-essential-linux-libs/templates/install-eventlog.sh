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
export PVERSION_EVENTLOG="<%= packageSoftwareVersion %>" &&



### EventLog
# CheckURI: http://www.balabit.com/downloads/files/eventlog/0.2/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="eventlog" &&
export PVERSION="$PVERSION_EVENTLOG" && 
export PVERSION_MAJOR=`echo $PVERSION | cut -d. -f1,2` &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="${PNAME}_$PVERSION.tar.gz" &&
export PURI="http://www.balabit.com/downloads/files/eventlog/$PVERSION_MAJOR/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0