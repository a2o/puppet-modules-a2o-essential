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



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_IMAP="<%= packageSoftwareVersion %>" &&
export PDESTDIR_IMAP="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Imap (Washington)
# CheckURI: ftp://ftp.cac.washington.edu/imap/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="imap" &&
export PVERSION="$PVERSION_IMAP" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="ftp://ftp.cac.washington.edu/imap/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&

export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&

# Adapt makefiles
cd src/osdep/unix &&
mv Makefile Makefile.tmp &&
cat Makefile.tmp \
  | sed -e 's/^GCCCFLAGS=.\+/GCCCFLAGS= -fPIC -O3 /' \
  > Makefile &&
cd ../../.. &&

# Build it
make slx SSLDIR=$PDESTDIR_OPENSSL &&

# Create shared library
mkdir tmp &&
cd tmp &&
ar xv ../c-client/c-client.a &&
gcc -shared -o c-client.so *.o &&
cd .. &&

# Manual installation
mkdir -p $PDESTDIR_IMAP/include &&
mkdir -p $PDESTDIR_IMAP/lib &&
cp c-client/*.h $PDESTDIR_IMAP/include &&
cp c-client/*.c $PDESTDIR_IMAP/lib &&
cp c-client/c-client.a  $PDESTDIR_IMAP/lib/libc-client.a  &&
cp      tmp/c-client.so $PDESTDIR_IMAP/lib/libc-client.so &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
