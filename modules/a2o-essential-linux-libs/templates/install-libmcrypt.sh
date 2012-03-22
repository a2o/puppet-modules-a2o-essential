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
export PVERSION_LIBMCRYPT="<%= packageSoftwareVersion %>" &&



### libmcrypt (not MCrypt)
# CheckURI: http://sourceforge.net/project/showfiles.php?group_id=87941
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="libmcrypt" &&
export PVERSION="$PVERSION_LIBMCRYPT" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://garr.dl.sourceforge.net/sourceforge/mcrypt/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0