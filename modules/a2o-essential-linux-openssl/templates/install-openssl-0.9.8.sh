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



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_OPENSSL=`echo "<%= packageVersion %>" | sed -e 's/_/-/'` &&
export PDESTDIR_OPENSSL="<%= destDir %>" &&



### OpenSSL
# CheckURI: http://openssl.org/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="openssl" &&
export PVERSION="$PVERSION_OPENSSL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.openssl.org/source/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
./config --prefix=$PDESTDIR_OPENSSL shared &&
make &&
make install &&

# Add 2 symlinks
ln -sf libcrypto.so.0.9.8 $PDESTDIR_OPENSSL/lib/libcrypto.so.0 &&
ln -sf libssl.so.0.9.8 $PDESTDIR_OPENSSL/lib/libssl.so.0 &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
