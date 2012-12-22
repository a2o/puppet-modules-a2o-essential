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



### socat
# CheckURI: http://www.dest-unreach.org/socat/
# ReqBy: kvm (za ukaze posiljat v monitor socket)
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="socat" &&
# INFO: 1.7.2.0 does not compile on betafix, weird (on slack 12.2 32bit in general)
# INFO: it does if config.h is modified with #define HAVE_LINUX_ERRQUEUE_H 1
# INFO: Old version was 1.7.1.3
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.dest-unreach.org/socat/download/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&

# TODO FIXME remove when obsolete
cp config.h config.h.orig &&
cat config.h.orig | sed -e 's@/\* #undef HAVE_LINUX_ERRQUEUE_H \*/@#define HAVE_LINUX_ERRQUEUE_H 1@' > config.h &&

make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
