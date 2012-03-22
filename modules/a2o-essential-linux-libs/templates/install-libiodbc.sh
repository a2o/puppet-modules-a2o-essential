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
export PVERSION_LIBIODBC="<%= packageSoftwareVersion %>" &&



### iODBC
# CheckURI: http://www.iodbc.org/dataspace/iodbc/wiki/iODBC/Downloads
# Req by: PHP for iodbc
cd $SRCROOT && . ../_functions.sh &&
export PNAME="libiodbc" &&
export PVERSION="$PVERSION_LIBIODBC" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.iodbc.org/downloads/iODBC/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --disable-gui &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0