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
export PVERSION_OPENSSH="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### OpenSSH - sys
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

# FIXME reinclude --with-ldflags=-static \

./configure --prefix=$PDESTDIR \
  --sysconfdir=/etc/ssh-sys \
  --with-ssl-dir=$PDESTDIR_OPENSSL \
  --with-privsep-path=/dev/shm/privsep \
  --with-default-path=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/ssh-sys/bin &&
make &&
make install &&

unset LD_LIBRARY_PATH &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR
