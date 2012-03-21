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



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_FREETDS="<%= packageSoftwareVersion %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### FreeTDS
# CheckURI: http://ibiblio.org/pub/Linux/ALPHA/freetds/stable/
# Req by: PHP for mssql
cd $SRCROOT && . ../_functions.sh &&
export PNAME="freetds" &&
export PVERSION="$PVERSION_FREETDS" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ibiblio.org/pub/Linux/ALPHA/freetds/stable/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure \
  --with-iodbc=/usr/local \
  --with-unixodbc=/usr/local \
  --enable-sybase-compat --enable-msdblib --enable-sspi \
  --with-openssl=$PDESTDIR_OPENSSL &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
