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
export PVERSION_BOOST="<%= packageSoftwareVersion %>" &&



### Boost
# CheckURI: http://www.boost.org/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="boost" &&
export PVERSION="$PVERSION_BOOST" &&
export PDIR="${PNAME}_`echo $PVERSION | sed -e 's/\./_/g'`" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://kent.dl.sourceforge.net/project/boost/boost/$PVERSION/$PFILE"

rm -rf $PDIR &&
GetUnpackCd &&

./bootstrap.sh &&
./b2 &&
./b2 install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0