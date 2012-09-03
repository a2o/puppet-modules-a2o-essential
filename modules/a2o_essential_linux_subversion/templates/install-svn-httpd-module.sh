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
export PVERSION_SVN="<%= softwareVersion %>" &&
export PDESTDIR_SVN="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Subversion
# CheckURI: http://subversion.tigris.org/
# Requires: libxml2, expat, neon, apr
cd $SRCROOT && . ../_functions.sh &&
export PNAME="subversion" &&
export PVERSION="$PVERSION_SVN" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.eu.apache.org/dist/subversion/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR_SVN \
  --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr \
  --with-apxs=$PDESTDIR_SVN/bin/apxs \
  --with-sqlite=/usr/local \
  --with-ssl &&
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
