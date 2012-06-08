#!/bin/bash



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_ACTIVEMQ="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### ActiveMQ
# CheckURI: http://www.openssh.com/
# Requires: openssl, zlib
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="apache-activemq" &&
export PVERSION="$PVERSION_ACTIVEMQ" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR-bin.tar.gz" &&
export PURI="http://apache.osuosl.org/activemq/apache-activemq/$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

rm -rf $PDESTDIR &&
mv $PDIR $PDESTDIR &&

cd $PDESTDIR &&
chown -R root.root . &&

# Create conf and datadir symlinks, store original folders
mv conf conf.dist &&
mv data data.dist &&

ln -s /etc/activemq ./conf &&
ln -s /var/activemq ./data &&



### Signal successful exit
true
