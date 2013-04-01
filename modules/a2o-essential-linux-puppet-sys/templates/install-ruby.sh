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



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_RUBY=`echo "<%= packageSoftwareVersion %>" | sed -e 's/_/-/'` &&
export PVERSION_RUBY_MAJOR=`echo "$PVERSION_RUBY" | cut -d. -f1,2` &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



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
export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&

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
rm -rf shadow-1.4.1 &&



### All done
exit 0
