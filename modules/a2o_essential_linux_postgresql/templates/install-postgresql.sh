#!/bin/bash



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_POSTGRESQL="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### MySQL
# CheckURI: http://ftp.arnes.si/mysql/Downloads/
cd $SRCROOT && . /var/src/_functions.sh &&
export PNAME="postgresql" &&
export PVERSION="$PVERSION_POSTGRESQL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ftp.postgresql.org/pub/source/v$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR \
  --with-openssl \
  --with-libraries=$PDESTDIR_OPENSSL/lib \
  --with-includes=$PDESTDIR_OPENSSL/include
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
