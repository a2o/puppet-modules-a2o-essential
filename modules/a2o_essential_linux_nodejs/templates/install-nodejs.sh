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



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_NODEJS="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### NodeJS
# CheckURI: http://nodejs.org/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="node" &&
export PVERSION="$PVERSION_NODEJS" &&
export PDIR="$PNAME-v$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://nodejs.org/dist/v$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
