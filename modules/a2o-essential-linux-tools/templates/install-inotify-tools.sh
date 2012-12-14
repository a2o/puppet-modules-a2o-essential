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
export PVERSION_SW="<%= packageSoftwareVersion %>" &&



### inotify tools
# CheckURI: http://sourceforge.net/project/showfiles.php?group_id=171752
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="inotify-tools" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PNAME-$PVERSION.tar.gz" &&
export PURI="http://downloads.sourceforge.net/sourceforge/inotify-tools/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make &&
(
  removepkg inotify-tools;
  make install &&
  ldconfig
) &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
