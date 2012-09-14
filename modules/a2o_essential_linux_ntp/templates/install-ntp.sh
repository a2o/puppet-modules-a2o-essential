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

./configure &&
make -j 2 &&

# WORKAROUND on 4.2.4p8 make install fails, we disable installing man page sntp.1
cp sntp/Makefile sntp/Makefile.tmp &&
cat sntp/Makefile.tmp | sed -e 's/dist_man_MANS = sntp.1/dist_man_MANS = /' > sntp/Makefile &&
rm sntp/Makefile.tmp &&

make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
# FIXME reinclude? Old configure line
#./configure \
#  --with-openssl-libdir=/usr/local/openssl-$PVERSION_OPENSSL/lib \
#  --with-openssl-incdir=/usr/local/openssl-$PVERSION_OPENSSL/include \
#  --with-crypto &&
