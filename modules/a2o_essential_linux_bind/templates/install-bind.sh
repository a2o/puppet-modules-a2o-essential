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


### Workaround
#
# At initial 'make install' bind creates /etc/named and places in there a file
# called 'bind.keys'. This breaks puppet catalog run as it tries to create a
# symlink to CHROOT/etc/named.
# Therefore - if only this file exists in that dir, move it to chroot and remove
# the directory to make space for symlink.
#
if [ -d /etc/named ]; then
    if [ -e /etc/named/bind.keys ]; then
	RES=`ls /etc/named/ | grep -c .`
	if [ "$RES" == "1" ]; then
	    mkdir -p /var/named/etc/named &&
	    mv /etc/named/bind.keys /var/named/etc/named &&
	    rmdir /etc/named
	fi
    fi
fi &&


### Create device files - WORKAROUND, can't do that in puppet.
export CHROOT_DIR="/var/named" &&
mkdir -p $CHROOT_DIR/dev &&
mkdir -p $CHROOT_DIR/etc &&

if [ ! -e $CHROOT_DIR/dev/null ]; then
    mknod $CHROOT_DIR/dev/null c 1 3
fi &&

if [ ! -e $CHROOT_DIR/dev/random ]; then
    mknod $CHROOT_DIR/dev/random c 1 8
fi &&

if [ ! -e $CHROOT_DIR/dev/zero ]; then
    mknod $CHROOT_DIR/dev/zero c 1 5
fi &&

if [ ! -e $CHROOT_DIR/etc/localtime ]; then
  cp -dpRrL /etc/localtime $CHROOT_DIR/etc/
else
  if ! diff -q /etc/localtime $CHROOT_DIR/etc/localtime > /dev/null; then
    cp -dpRrL /etc/localtime $CHROOT_DIR/etc/
  fi
fi
