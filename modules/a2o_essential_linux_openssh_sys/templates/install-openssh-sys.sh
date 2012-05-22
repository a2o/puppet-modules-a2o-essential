#!/bin/bash



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_OPENSSH="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### OpenSSH - sys
# CheckURI: http://www.openssh.com/
# Requires: openssl, zlib
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="openssh" &&
export PVERSION="$PVERSION_OPENSSH" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://mirror.switch.ch/ftp/pub/OpenBSD/OpenSSH/portable/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&
ldconfig &&

# FIXME reinclude --with-ldflags=-static \

./configure --prefix=$PDESTDIR \
  --sysconfdir=/etc/ssh-sys \
  --with-ssl-dir=$PDESTDIR_OPENSSL \
  --with-privsep-path=/dev/shm/privsep \
  --with-default-path=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/ssh-sys/bin &&
make &&
make install &&

unset LD_LIBRARY_PATH &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR
