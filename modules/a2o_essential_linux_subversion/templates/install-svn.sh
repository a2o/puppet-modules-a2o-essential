#!/bin/bash



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
  --with-sqlite=/usr/local \
  --with-ssl &&
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
