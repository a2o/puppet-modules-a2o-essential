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
export PVERSION_OPENSSH="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### OpenSSH
# CheckURI: http://www.openssh.com/
# Requires: openssl, zlib
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="openssh" &&
export PVERSION="$PVERSION_OPENSSH" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://mirror.switch.ch/ftp/pub/OpenBSD/OpenSSH/portable/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&
ldconfig &&

# Enable chrooting into non-root-owned directory
wget http://source.a2o.si/patches/openssh-5.9p1_no-chroot-check.diff &&
patch -p1 < openssh-5.9p1_no-chroot-check.diff &&

# FIXME reinclude --with-ldflags=-static \

./configure --prefix=$PDESTDIR \
  --sysconfdir=/etc/ssh \
  --with-ssl-dir=$PDESTDIR_OPENSSL \
  --with-zlib=$PDESTDIR \
  --with-privsep-path=/var/empty \
  --with-default-path=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/ssh/bin &&
make &&
make install &&

unset LD_LIBRARY_PATH &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
