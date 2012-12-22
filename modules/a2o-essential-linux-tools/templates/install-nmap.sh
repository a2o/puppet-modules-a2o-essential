#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) Bostjan Skufca                                            #
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
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Nmap
# CheckURI: http://nmap.org/dist/
# CHECK - disable ZenMap
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="nmap" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.bz2" &&
export PURI="http://nmap.org/dist/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --without-zenmap &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
