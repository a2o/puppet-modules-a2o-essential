#!/bin/bash



# Compile directory
export SRCROOT="/var/src/puppet-sys" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_RUBY="1.8.7-p371" &&
export PVERSION_RUBY_MAJOR=`echo "$PVERSION_RUBY" | cut -d. -f1,2` &&
export PVERSION_GEMS="1.8.17" &&
export PDESTDIR="/usr/local/puppet-sys-2.7.21-init" &&
export PDESTDIR_OPENSSL="/usr/local/openssl-init" &&



### Ruby
# CheckURI: http://www.ruby-lang.org/en/downloads/
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="ruby" &&
export PVERSION="$PVERSION_RUBY" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ftp.ruby-lang.org/pub/ruby/$PVERSION_RUBY_MAJOR/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Enable OpenSSL support like this
export CPPFLAGS="-I$PDESTDIR_OPENSSL/include" &&
export LDFLAGS="-L$PDESTDIR_OPENSSL/lib" &&

# Issues with GCC 4.7.x
if [ `gcc --version | head -n1 | fgrep " 4.7." -c` == "1" ]; then
    export CFLAGS="-O2 -fno-tree-dce -fno-optimize-sibling-calls" &&
    wget http://source.a2o.si/patches/ruby-1.8.7-gcc-4.7.diff &&
    patch -p0 < ruby-1.8.7-gcc-4.7.diff
fi &&

./configure --prefix=$PDESTDIR \
  --enable-shared &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



### Libshadow
# Originates from here: http://ftp.de.debian.org/debian/pool/main/libs/libshadow-ruby/libshadow-ruby_1.4.1.orig.tar.gz
cd $SRCROOT &&
wget -c http://source.a2o.si/source-packages/libshadow-ruby_1.4.1.orig.tar.gz &&
rm -rf shadow-1.4.1 &&
tar -xzf libshadow-ruby_1.4.1.orig.tar.gz &&
cd shadow-1.4.1 &&

$PDESTDIR/bin/ruby extconf.rb &&
make &&
make install &&

cd $SRCROOT &&
rm -rf shadow-1.4.1
