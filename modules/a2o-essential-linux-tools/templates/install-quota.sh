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



### QuotaTools
# CheckURI: http://sourceforge.net/projects/linuxquota/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="quota" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="quota-tools" &&
export PFILE="$PNAME-$PVERSION.tar.gz" &&
export PURI="http://surfnet.dl.sourceforge.net/sourceforge/linuxquota/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
