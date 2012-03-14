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
# Authors: Bostjan Skufca <bostjan@a2o.si>                                #
###########################################################################



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_GIT="<%= packageSoftwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Git
# CheckURI: http://www.git-scm.org/
# Requires: openssl, curl, expat
cd $SRCROOT && . ../_functions.sh &&
export PNAME="git" &&
export PVERSION="$PVERSION_GIT" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
#export PURI="http://git-core.googlecode.com/files/$PFILE" &&
export PURI="http://source.a2o.si/source-packages/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR \
  --with-openssl=$PDESTDIR_OPENSSL \
  --with-curl \
  --with-expat &&

# FIXME REMOVE workaround error while compiling 1.7.9.1
mv Makefile Makefile.orig &&
cat Makefile.orig | sed -e 's/^EXTLIBS = *$/EXTLIBS = -lcharset/' > Makefile &&

make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
