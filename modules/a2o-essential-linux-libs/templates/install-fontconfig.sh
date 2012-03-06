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
export PVERSION_FONTCONFIG="<%= packageSoftwareVersion %>" &&



### Fontconfig
# CheckURI: http://fontconfig.org/release/
# Req: FreeType2, expat
cd $SRCROOT && . ../_functions.sh &&
export PNAME="fontconfig" &&
export PVERSION="$PVERSION_FONTCONFIG" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://fontconfig.org/release/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make -j 2 &&
make install &&

# 2.8.0 on 32bit slack, after compilation install would not work correctly for the first time
if [ "$?" != "0" ]; then
  ldconfig
  make install
  if [ "$?" != "0" ]; then
    echo "Error installing fontconfig"
    exit 1
  fi
fi &&

ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
