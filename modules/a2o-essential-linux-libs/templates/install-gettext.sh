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
export PVERSION_GETTEXT="<%= packageSoftwareVersion %>" &&



### gettext
# CheckURI: http://gd.tuwien.ac.at/gnu/gnusrc/gettext/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="gettext" &&
export PVERSION="$PVERSION_GETTEXT" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ftp.gnu.org/pub/gnu/gettext/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make -j 2 &&
(
  removepkg gettext;
  removepkg gettext-tools;
  make install
) &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0