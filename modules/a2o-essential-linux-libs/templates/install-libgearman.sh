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
export PVERSION_LIBGEARMAN="<%= packageSoftwareVersion %>" &&



### libgearman
# CheckURI: http://gearman.org/index.php?id=download
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="gearmand" &&
export PVERSION="$PVERSION_LIBGEARMAN" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://launchpad.net/gearmand/trunk/$PVERSION/+download/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make &&
make install-libLTLIBRARIES &&
make install-nobase_includeHEADERS &&
make install-pkgconfigDATA &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
