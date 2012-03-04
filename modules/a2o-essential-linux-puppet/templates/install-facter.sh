#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_FACTER="<%= packageSoftwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### Fracter
# CheckURI: http://www.puppetlabs.com/downloads/facter/
cd $SRCROOT && . /var/src/_functions.sh &&
export PNAME="facter" &&
export PVERSION="$PVERSION_FACTER" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.puppetlabs.com/downloads/facter/$PFILE" &&
GetUnpackClean &&
$PDESTDIR/bin/ruby install.rb &&

cd $SRCROOT &&
rm -rf $PDIR
