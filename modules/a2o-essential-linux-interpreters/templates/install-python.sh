#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_PYTHON=`echo "<%= packageSoftwareVersion %>" | sed -e 's/_/-/'` &&
export PDESTDIR="<%= destDir %>" &&



### Python
# CheckURI: http://www.python.org/download/
cd $SRCROOT && . /var/src/_functions.sh &&
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
