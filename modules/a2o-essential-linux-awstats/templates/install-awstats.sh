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
export PVERSION_AWSTATS="<%= packageSoftwareVersion %>" &&
export PDESTDIR_AWSTATS="<%= destDir %>" &&



### AWstats
# CheckURI: http://awstats.sourceforge.net/#DOWNLOAD
# URI: http://awstats.sourceforge.net/
# Requires: perl
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="awstats" &&
export PVERSION="$PVERSION_AWSTATS" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://garr.dl.sourceforge.net/project/awstats/AWStats/$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

rm -rf $PDESTDIR_AWSTATS &&
cp -R $PDIR $PDESTDIR_AWSTATS &&

# Move CGIs to separate dir to allow common system .htaccess and custom .htaccess for client accesses
cd $PDESTDIR_AWSTATS/wwwroot &&
mkdir cgis &&
mv cgi-bin/ cgis/ &&
ln -s cgis/cgi-bin cgi-bin &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
