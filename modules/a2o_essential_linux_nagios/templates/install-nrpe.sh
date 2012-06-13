#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_NRPE="<%= softwareVersion %>" &&
export PDESTDIR_NRPE="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Download and install
# CheckURI: http://www.nagios.org/download/core/thanks/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="nrpe" &&
export PVERSION="$PVERSION_NRPE" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://garr.dl.sourceforge.net/sourceforge/nagios/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR_NRPE --sysconfdir=/etc/nagios --localstatedir=/var/nagios \
  --enable-ssl \
  --with-ssl-inc=$PDESTDIR_OPENSSL/include \
  --with-ssl-lib=$PDESTDIR_OPENSSL/lib \
  --enable-command-args &&

make all &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
