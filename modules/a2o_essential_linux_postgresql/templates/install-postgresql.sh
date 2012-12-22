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
export PVERSION_POSTGRESQL="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### MySQL
# CheckURI: http://ftp.arnes.si/mysql/Downloads/
cd $SRCROOT && . /var/src/_functions.sh &&
export PNAME="postgresql" &&
export PVERSION="$PVERSION_POSTGRESQL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ftp.postgresql.org/pub/source/v$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR \
  --with-openssl \
  --with-libraries=$PDESTDIR_OPENSSL/lib \
  --with-includes=$PDESTDIR_OPENSSL/include
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
