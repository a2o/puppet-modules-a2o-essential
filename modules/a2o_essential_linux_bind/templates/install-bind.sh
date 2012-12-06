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
export PVERSION_SW=`echo '<%= softwareVersion %>' | sed -e 's/_/-/'` &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= destDir_openssl %>" &&



### BIND (named)
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="bind" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ftp.isc.org/isc/bind9/$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&

./configure --prefix=$PDESTDIR \
  --sysconfdir=/etc/named --localstatedir=/var/named \
  --with-openssl=$PDESTDIR_OPENSSL &&
### Warning: parallel compiles are not supported (-jX)
make &&
make install &&

mkdir -p /var/named/$PDESTDIR_OPENSSL &&
cp -pR $PDESTDIR_OPENSSL/lib /var/named/$PDESTDIR_OPENSSL &&

unset LD_LIBRARY_PATH &&

cd $SRCROOT &&
rm -rf $PDIR &&



### Create device files - WORKAROUND, can't do that in puppet.
mkdir -p /var/named/dev &&
mkdir -p /var/named/etc &&

if [ ! -e /var/named/dev/log ]; then
  cp -dpPR /dev/log       /var/named/dev/
fi &&

if [ ! -e /var/named/dev/random ]; then
  cp -dpPR /dev/random    /var/named/dev/
fi &&

if [ ! -e /var/named/dev/zero ]; then
  cp -dpPR /dev/zero      /var/named/dev/
fi &&

if [ ! -e /var/named/etc/localtime ]; then
  cp -dpRrL /etc/localtime /var/named/etc/
else
  if ! diff -q /etc/localtime /var/named/etc/localtime > /dev/null; then
    cp -dpRrL /etc/localtime /var/named/etc/
  fi
fi
