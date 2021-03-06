#!/bin/bash



# Compile directory
export SRCROOT="/var/src/libs" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_OPENSSL="1.0.1e" &&
export PDESTDIR_OPENSSL="/usr/local/openssl-$PVERSION_OPENSSL-init" &&



### OpenSSL
# CheckURI: http://openssl.org/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="openssl" &&
export PVERSION="$PVERSION_OPENSSL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.openssl.org/source/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&

./config --prefix=$PDESTDIR_OPENSSL shared &&
make &&
make install &&

# Add 2 symlinks
ln -sf libcrypto.so.1.0.0 $PDESTDIR_OPENSSL/lib/libcrypto.so.1 &&
ln -sf libssl.so.1.0.0 $PDESTDIR_OPENSSL/lib/libssl.so.1 &&

# Add main symlink in /usr/local
if [ ! -e /usr/local/openssl-init ]; then
    ln -s openssl-$PVERSION_OPENSSL-init /usr/local/openssl-init
fi

cd $SRCROOT &&
rm -rf $PDIR &&



true
