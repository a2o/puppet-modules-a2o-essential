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
export PVERSION_SW="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### QEMU-kvm
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="qemu-kvm" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://downloads.sourceforge.net/project/kvm/qemu-kvm/$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig" &&

./configure \
  --prefix=$PDESTDIR \
  --enable-vnc-tls &&
make &&
make install &&

unset PKG_CONFIG_PATH &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
