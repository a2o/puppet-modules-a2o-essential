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
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_MCOLLECTIVE="<%= softwareVersion %>" &&
export PVERSION_PLUGINS="<%= pluginsVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### Mcollective
# CheckURI: http://www.puppetlabs.com/misc/download-options/
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="mcollective" &&
export PVERSION="$PVERSION_MCOLLECTIVE" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="http://puppetlabs.com/downloads/mcollective/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&

# Chown
chown -R root.root ./ &&

# Cleanup
mkdir -p sbin &&
mv mc-* sbin/ &&
mv mco  sbin/ &&

# Get plugins
wget http://source.a2o.si/custom-packages/mcollective-plugins-$PVERSION_PLUGINS.tar.gz &&
tar -xzf mcollective-plugins-$PVERSION_PLUGINS.tar.gz &&
ln -s mcollective-plugins-$PVERSION_PLUGINS mcollective-plugins &&

# Move to appropriate locations
cp -pR mcollective-plugins/* . &&

# Install to destdir
cd .. &&
rm -rf $PDESTDIR &&
mv $PDIR $PDESTDIR &&



exit 0
