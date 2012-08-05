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



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_STATSD="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### Statsd
# CheckURI: https://github.com/etsy/statsd/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="node" &&
export PVERSION="$PVERSION_STATSD" &&
export PDIR="$PNAME-$PVERSION" &&

rm -rf $PDIR &&
git clone git://github.com/etsy/statsd.git $PDIR &&

cd $PDIR &&
git checkout v$PVERSION &&
cd .. &&

rm -rf $PDESTDIR &&
mv $PDIR $PDESTDIR
