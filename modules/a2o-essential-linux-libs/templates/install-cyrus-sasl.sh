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



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_CYRUS_SASL="<%= packageSoftwareVersion %>" &&



### Cyrus SASL
# CheckURI: ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="cyrus-sasl" &&
export PVERSION="$PVERSION_CYRUS_SASL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Fix for GCC 4.4
sed -i 's/^#elif WITH_DES$/#elif defined(WITH_DES)/' plugins/digestmd5.c &&
./configure &&
make &&
make install &&

if [ -e /usr/lib/sasl2 ]; then
    if [ -h /usr/lib/sasl2 ]; then
    rm -f /usr/lib/sasl2
    else
    mv /usr/lib/sasl2 /usr/lib/sasl2.bak.a2o
    fi
fi &&
ln -sf /usr/local/lib/sasl2 /usr/lib/sasl2 &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
