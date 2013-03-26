#!/bin/bash



# Compile directory
export SRCROOT="/var/src/puppet-sys" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_FACTER="1.6.18" &&
export PDESTDIR="/usr/local/puppet-sys-2.7.21-init" &&



### Fracter
# CheckURI: http://www.puppetlabs.com/downloads/facter/
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="facter" &&
export PVERSION="$PVERSION_FACTER" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.puppetlabs.com/downloads/facter/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

$PDESTDIR/bin/ruby install.rb &&

cd $SRCROOT &&
rm -rf $PDIR
