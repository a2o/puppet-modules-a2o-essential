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
export PVERSION_SW="<%= softwareVersion %>" &&



### At daemon
# CheckURI: ftp://ftp.debian.org/debian/pool/main/a/at
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="at" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="${PNAME}_${PVERSION}.orig.tar.gz" &&
export PURI="ftp://ftp.debian.org/debian/pool/main/a/at/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --with-loadavg_mx=64 &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
