#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_RUBY=`echo "<%= softwareVersion %>" | sed -e 's/_/-/'` &&
export PVERSION_RUBY_MAJOR=`echo "$PVERSION_RUBY" | cut -d. -f1,2` &&
export PVERSION_GEMS="<%= softwareVersion_gems %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Ruby
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
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="rubygems" &&
export PVERSION="$PVERSION_GEMS" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="http://production.cf.rubygems.org/rubygems/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

$PDESTDIR/bin/ruby setup.rb &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
