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
