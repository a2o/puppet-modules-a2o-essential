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
export PVERSION_LIBXML2="<%= packageSoftwareVersion %>" &&



### libxml2
# CheckURI: ftp://xmlsoft.org/libxml2/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="libxml2" &&
export PVERSION="$PVERSION_LIBXML2" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="ftp://xmlsoft.org/libxml2/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --without-python &&
make -j 2 &&
make install &&
ldconfig

# WORKAROUND: Make install does not return non-zero exit status on failure
if [[ ! -f /usr/local/lib/libxml2.so.$PVERSION && ! -f /usr/local/lib64/libxml2.so.$PVERSION ]]; then
    echo "ERROR: Installation was not successful."
    echo "ERROR: File does not exist: /usr/local/lib\*/libxml2.so.$PVERSION"
    exit 1
fi

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
