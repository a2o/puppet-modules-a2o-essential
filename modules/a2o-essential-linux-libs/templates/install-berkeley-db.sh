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
export PVERSION_BDB="<%= packageSoftwareVersion %>" &&



### Oracle BerkeleyDB 5
# CheckURI: http://www.oracle.com/technology/software/products/berkeley-db/index.html
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="db" &&
# Don't migrate to 5.x.x because PHP does not support it yet - maybe we should remove it alltogether
export PVERSION="$PVERSION_BDB" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://download.oracle.com/berkeley-db/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

cd ./build_unix &&
../dist/configure --prefix=/usr/local &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



# FIXME WORKAROUND - crappy installations - postfix
if [ ! -e /usr/include/db.h ]; then
    ln -sf /usr/local/include/db.h /usr/include/db.h
fi &&



exit 0
