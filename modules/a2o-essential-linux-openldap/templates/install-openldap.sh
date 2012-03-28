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
export PVERSION_OPENLDAP="<%= packageSoftwareVersion %>" &&
export PDESTDIR_OPENLDAP="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### OpenLDAP
# CheckURI: http://www.openldap.org/software/download/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="openldap" &&
export PVERSION="$PVERSION_OPENLDAP" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export CFLAGS="-I$PDESTDIR_OPENSSL/include" &&
export LDFLAGS="-L$PDESTDIR_OPENSSL/lib" &&
export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&

./configure --prefix=$PDESTDIR_OPENLDAP \
  --sysconfdir=/etc --localstatedir=/var \
  --enable-crypt --enable-lmpasswd --enable-spasswd \
  --enable-hdb \
  --with-tls=openssl &&
make depend &&
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
