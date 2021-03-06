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
export PVERSION_PYTHON=`echo "<%= packageSoftwareVersion %>" | sed -e 's/_/-/'` &&
export PDESTDIR="<%= destDir %>" &&



### Python
# CheckURI: http://www.python.org/download/
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="Python" &&
export PVERSION="$PVERSION_PYTHON" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="http://www.python.org/ftp/python/$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR \
  --enable-shared &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
