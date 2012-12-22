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
export PVERSION_OPENSSL=`echo "<%= softwareVersion %>" | sed -e 's/_/-/'` &&
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

# Add versioning information
wget http://source.a2o.si/patches/openssl-1.0.0i-symbolVersioning.diff &&
patch -p1 < openssl-1.0.0i-symbolVersioning.diff &&

./config --prefix=$PDESTDIR_OPENSSL shared &&

# WARNING: Don't argument make with -jX, it will compile but it won't work (tnx for notice David {a@t} kuridza.si)
make &&
make install &&

# Add 2 symlinks
ln -sf libcrypto.so.1.0.0 $PDESTDIR_OPENSSL/lib/libcrypto.so.0 &&
ln -sf libssl.so.1.0.0 $PDESTDIR_OPENSSL/lib/libssl.so.0 &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
