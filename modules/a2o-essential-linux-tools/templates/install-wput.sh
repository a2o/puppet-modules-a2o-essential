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



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SW="<%= packageSoftwareVersion %>" &&



### Wput
# CheckURI: http://sourceforge.net/project/showfiles.php?group_id=141519
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="wput" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="http://garr.dl.sourceforge.net/sourceforge/wput/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --with-ssl &&
make &&
rm -f /usr/local/bin/wdel &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0