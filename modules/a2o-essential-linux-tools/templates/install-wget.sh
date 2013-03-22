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
export PVERSION_SW="<%= packageSoftwareVersion %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Wget
# CheckURI: http://ftp.gnu.org/gnu/wget/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="wget" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ftp.gnu.org/gnu/wget/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Fixup: without this it does not compile with openssl support, and uses gnutls in that case
export CFLAGS="-I$PDESTDIR_OPENSSL/include" &&
export LDFLAGS="-L$PDESTDIR_OPENSSL/lib" &&

./configure \
  --sysconfdir=/etc \
  --with-ssl=openssl --with-libssl-prefix=$PDESTDIR_OPENSSL &&
make &&
(
  removepkg wget;
  rm -f /etc/wgetrc;
  make install;
  PATH="$PATH"
) &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
