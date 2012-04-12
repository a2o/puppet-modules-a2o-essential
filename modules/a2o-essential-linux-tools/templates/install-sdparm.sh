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



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SW="<%= packageSoftwareVersion %>" &&



### SDparm
# CheckURI: http://sg.danny.cz/sg/sdparm.html#mozTocId166213
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="sdparm" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="http://sg.danny.cz/sg/p/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix="" --datarootdir=/usr/share &&
make &&
(
  removepkg sdparm;
  make install;
) &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
