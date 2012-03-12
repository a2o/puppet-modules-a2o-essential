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
export PVERSION_PUPPET="<%= packageSoftwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### Puppet
# CheckURI: http://www.puppetlabs.com/downloads/puppet/
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="puppet" &&
export PVERSION="$PVERSION_PUPPET" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.puppetlabs.com/downloads/puppet/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Add modulepath globbing support
wget http://source.a2o.si/patches/puppet-2.7.6_0.1-modulepath-globbing.diff &&
cat puppet-2.7.6_0.1-modulepath-globbing.diff | patch -p0 &&

mkdir -p $PDESTDIR/sbin &&
$PDESTDIR/bin/ruby install.rb &&

cd $SRCROOT &&
rm -rf $PDIR &&



### Fix the default confdir and vardir
cat $PDESTDIR/lib/ruby/site_ruby/1.8/puppet/util/run_mode.rb \
  | sed -e 's#"/etc/puppet"#"/etc/puppet-sys"#' \
  | sed -e 's#"/var/lib/puppet"#"/var/lib/puppet-sys"#' \
  > /tmp/run_mode.rb &&
mv /tmp/run_mode.rb $PDESTDIR/lib/ruby/site_ruby/1.8/puppet/util/run_mode.rb
