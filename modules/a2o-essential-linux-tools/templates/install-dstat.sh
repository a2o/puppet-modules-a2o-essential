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



### Dstat
# CheckURI: http://dag.wieers.com/home-made/dstat/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="dstat" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.bz2" &&
export PURI="http://dag.wieers.com/home-made/dstat/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

rm -rf /usr/local/$PDIR &&
mv $PDIR /usr/local &&
rm -f /usr/local/dstat &&
ln -s $PDIR /usr/local/dstat &&
rm -f /usr/local/bin/dstat &&
ln -s /usr/local/dstat/dstat /usr/local/bin/dstat &&



exit 0
