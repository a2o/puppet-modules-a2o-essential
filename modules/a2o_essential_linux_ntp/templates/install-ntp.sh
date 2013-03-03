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
export PVERSION_SW=`echo "<%= softwareVersion %>" | sed -e 's/_//'` &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### ntp
# CheckURI: http://www.ntp.org/downloads.html
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="ntp" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# MOD_NANO undefined workaround
wget http://source.a2o.si/patches/ntp-patch-MOD_NANO.diff &&
patch -p1 < ntp-patch-MOD_NANO.diff &&

./configure \
  --with-openssl-libdir=$PDESTDIR_OPENSSL/lib \
  --with-openssl-incdir=$PDESTDIR_OPENSSL/include \
  --with-crypto &&
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
