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



### Iotop
# CheckURI: http://guichaz.free.fr/iotop/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="iotop" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://guichaz.free.fr/iotop/files/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

rm -rf /usr/local/$PDIR &&
mv $PDIR /usr/local &&
rm -f /usr/local/iotop &&
ln -s $PDIR /usr/local/iotop &&
rm -f /usr/local/bin/iotop &&
ln -s /usr/local/iotop/iotop.py /usr/local/bin/iotop &&



exit 0
