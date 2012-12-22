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
export PVERSION_GNUTLS="<%= packageSoftwareVersion %>" &&



### GnuTLS
# CheckURI: ftp://ftp.gnu.org/pub/gnu/gnutls/
# ReqBy: logrotate
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="gnutls" &&
export PVERSION="$PVERSION_GNUTLS" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.xz" &&
export PURI="ftp://ftp.gnu.org/pub/gnu/gnutls/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
