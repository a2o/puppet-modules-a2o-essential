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



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SW="<%= softwareVersion %>" &&



### Install
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="lftp" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.xz" &&
export PURI="ftp://ftp.tuwien.ac.at/infosys/browsers/ftp/lftp/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig &&

./configure &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
