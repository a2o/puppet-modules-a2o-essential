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
export PVERSION_RSYNC="<%= packageSoftwareVersion %>" &&



### rsync
# CheckURI: http://rsync.samba.org/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="rsync" &&
export PVERSION="$PVERSION_RSYNC" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://rsync.samba.org/ftp/rsync/src/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --sysconfdir=/etc &&
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
