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



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SW="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Keepalived
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="keepalived" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.keepalived.org/software/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export CFLAGS="-I$PDESTDIR_OPENSSL/include" &&
export LDFLAGS="-L$PDESTDIR_OPENSSL/lib" &&
export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&

./configure --prefix=$PDESTDIR &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
