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
export PVERSION_SW="<%= softwareVersion %>" &&



### ifUpDown
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="ifupdown" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="${PNAME}_$PVERSION.tar.gz" &&
export PURI="http://ftp.de.debian.org/debian/pool/main/i/ifupdown/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

make &&
rm -f /sbin/ifdown &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
