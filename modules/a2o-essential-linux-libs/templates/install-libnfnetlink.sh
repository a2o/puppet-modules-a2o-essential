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
export PVERSION_LIBNFNETLINK="<%= packageSoftwareVersion %>" &&



### libnfnetlink
# CheckURI: http://www.netfilter.org/projects/libnfnetlink/downloads.html
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="libnfnetlink" &&
export PVERSION="$PVERSION_LIBNFNETLINK" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.bz2" &&
export PURI="http://www.netfilter.org/projects/libnfnetlink/files/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
