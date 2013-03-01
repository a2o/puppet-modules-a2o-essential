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



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_CURL="<%= packageSoftwareVersion %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Curl
# CheckURI: http://curl.haxx.se/download.html
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="curl" &&
export PVERSION="$PVERSION_CURL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://curl.haxx.se/download/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

### Because of this error: /usr/local/bin/curl-config: line 140: CPPFLAG_CURL_STATICLIB: command not found
# Supposedly fixed in 7.28.0
#wget --no-check-certificate https://trac.macports.org/raw-attachment/ticket/35631/patch-curl-config.diff &&
#patch -p0 < patch-curl-config.diff &&

# Disable SSLv2 support entirely
wget http://source.a2o.si/patches/curl-7.27.0_sslv2-disable.diff &&
patch -p0 < curl-7.27.0_sslv2-disable.diff &&

export LD_LIBRARY_PATH=$PDESTDIR_OPENSSL/lib &&

./configure --with-ssl=$PDESTDIR_OPENSSL \
  --with-ca-bundle=/etc/ssl/certs/curl-ca-bundle.crt \
  --enable-ipv6 \
  --without-libssh2 &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
