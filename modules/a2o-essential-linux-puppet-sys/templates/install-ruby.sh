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
export PVERSION_RUBY=`echo "<%= packageSoftwareVersion %>" | sed -e 's/_/-/'` &&
export PVERSION_RUBY_MAJOR=`echo "$PVERSION_RUBY" | cut -d. -f1,2` &&
export PVERSION_GEMS="<%=  packageSoftwareVersion_gems  %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Ruby
# CheckURI: http://www.ruby-lang.org/en/downloads/
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="ruby" &&
export PVERSION="$PVERSION_RUBY" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="ftp://ftp.ruby-lang.org/pub/ruby/$PVERSION_RUBY_MAJOR/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR \
  --enable-shared \
  --with-openssl-dir=$PDESTDIR_OPENSSL &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



### Gems
# CheckURI: http://rubyforge.org/frs/?group_id=126
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="rubygems" &&
export PVERSION="$PVERSION_GEMS" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="http://production.cf.rubygems.org/rubygems/$PFILE" &&
GetUnpackClean &&
$PDESTDIR/bin/ruby setup.rb &&

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